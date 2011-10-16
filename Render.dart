int grids=0;


void render(Queue<Shape> split_shapes, Projection camera, ZBuffer zbuffer, ColorBuffer screen,
            Function finishedCallback)
{
    int num_rendered_polys = 0;
    List<Micropolygon> polys = new List<Micropolygon>();
    Microgrid grid = new Microgrid();

    renderStep() {
        Shape current_shape = split_shapes.removeLast();
        int rateU = current_shape.diceRateU;
        int rateV = current_shape.diceRateV;
        grid.allocate(rateU, rateV);
        current_shape.dice(grid);
    
        displace(grid);
        shade(grid);

        grid.project(camera);

        grid.bust(polys);
        
        num_rendered_polys += polys.length;

        for( int i=0;i<polys.length;i++) {
            polys[i].rasterize(zbuffer, screen);
        }

        if (grids%100==0)
          screen.flush();

        grids++;

        grid.clear();
        polys.clear();
    }
    
    // Is there a cleaner way of implementing this?
    Function renderLoop;
    
    renderLoop = () {
      if (!split_shapes.isEmpty()) {
         renderStep();
         window.setTimeout(() {renderLoop();}, 0);
      } else {
        finishedCallback();
      }
    };
    
    renderLoop();

    print("Rendered $num_rendered_polys micropolygons\n");
}
