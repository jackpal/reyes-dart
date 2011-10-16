class Shape {
  SurfaceData surfaceData;
  int diceRateU, diceRateV;

  Shape() {
    surfaceData = new SurfaceData.whole();
  }

  abstract void split(Queue<Shape> unsplit_shapes, bool splitV);

  abstract P3d evalP(double u, double v);
  abstract P3d evalN(double u, double v);

  void dice(Microgrid grid) {
    double u,v;

    P3d p;

    int sizeX = grid.w;
    int sizeY = grid.h;

    grid.startU = surfaceData.startU;
    grid.startV = surfaceData.startV;
    grid.endU = surfaceData.endU;
    grid.endV = surfaceData.endV;


    for(int uu = 0; uu < sizeX; uu++)
    {
        u = (surfaceData.startU + ((surfaceData.endU - surfaceData.startU) * uu.toDouble()) / (sizeX-1).toDouble());
        
        for(int vv = 0; vv < sizeY; vv++)
        {
            v = (surfaceData.startV+((surfaceData.endV - surfaceData.startV) * vv.toDouble()) / (sizeY-1).toDouble());         

            grid.setVertex(uu, vv, evalP(u,v));
            grid.setNormal(uu, vv, evalN(u,v));
        }
    }
  }

  // void debugDraw(Projection camera);
}