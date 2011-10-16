bool removable(Microgrid grid, Projection camera) {
    BoundingBox bb = grid.getBoundingBox();

    if ( bb.max.x < -camera.screenWidth/2.0 || 
        bb.min.x > camera.screenWidth/2.0 ||
        bb.max.y < -camera.screenHeight/2.0 || 
        bb.min.y > camera.screenHeight/2.0 )
        return true;

    if(bb.max.z < 0.1 || bb.min.z > 1000)
        return true;

    return false;
}

final SPLIT_NO = 0;
final SPLIT_U = 1;
final SPLIT_V = 2;

int splittable(Microgrid grid, Shape current_shape)
{
  // TODO: make shadingRate a property of a shape.
  double shadingRate = 1.0;

    P2d estimate = grid.rasterEstimate();
//  current_shape->dice_rate_u = current_shape->dice_rate_v = PowerOfTwo(ceil(max(estimate.x, estimate.y)));
    
    double estimateArea = estimate.x * estimate.y;
    double shadedPixels = estimateArea / shadingRate;

    current_shape.diceRateU = /*PowerOfTwo*/(Math.max(1.0, (shadedPixels / estimate.x).ceil()));
    current_shape.diceRateV = /*PowerOfTwo*/(Math.max(1.0, (shadedPixels / estimate.y).ceil()));

    int max_u = Math.max(1, (estimate.x/grid.w).toInt());
    int max_v = Math.max(1, (estimate.y/grid.h).toInt());

    if(max_u>32 && current_shape.surfaceData.maxU > 32 && current_shape.surfaceData.generation>14)
        return SPLIT_NO;

    if(max_v>32 && current_shape.surfaceData.maxV > 32 && current_shape.surfaceData.generation>14)
        return SPLIT_NO;

    if(current_shape.surfaceData.generation>20)
    {   
            return SPLIT_NO;       
    }
    
    if(Math.max(estimate.x, estimate.y) <= 32.0)
    {
      return SPLIT_NO;
    }
    
    current_shape.surfaceData.maxU = max_u;
    current_shape.surfaceData.maxV = max_v;

    return (estimate.x > estimate.y ) ?
            SPLIT_U : SPLIT_V;
}

void boundSplit(Queue<Shape> unsplit_shapes, Queue<Shape> split_shapes, Projection camera)
{
    Microgrid grid = new Microgrid();
    grid.allocate(8,8);
    
    do
    {
        Shape current_shape = unsplit_shapes.removeFirst();

        //Dice the shape and project the resulting microgrid
        //to determine its screen space bounding box

        current_shape.dice(grid);

        displace(grid);
        grid.project(camera);

        if (removable(grid, camera)) {
            continue;
        }

        int splitResult = splittable(grid,current_shape);
        if (splitResult != SPLIT_NO) {
            current_shape.split(unsplit_shapes, splitResult == SPLIT_V);
        }
        else
        {
            split_shapes.addLast(current_shape);
        }
    }
    while(!unsplit_shapes.isEmpty());
}