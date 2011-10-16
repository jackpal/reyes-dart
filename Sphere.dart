class Sphere extends Shape {
    final P3d _location;
    final double _radius;

    Sphere(P3d loc, double rad) : super(),
      _location = loc, _radius = rad;

    void split(Queue<Shape> unsplit_shapes, bool splitV) {
      Sphere child1 = new Sphere(_location, _radius);
      Sphere child2 = new Sphere(_location, _radius);

      child1.surfaceData = new SurfaceData.split(surfaceData,
        splitV, true);
      child2.surfaceData = new SurfaceData.split(surfaceData,
        splitV, false);

      unsplit_shapes.addFirst(child1);
      unsplit_shapes.addFirst(child2);
    }

    P3d evalP(double u, double v) {
      if (u < 0.0 || v < 0.0 || u > 1.0 || v > 1.0) {
        throw new Exception("bad u, v");
      }
      
      double vang = Math.PI*(v*2.0-1.0)/2.0;
      double uang = (u*Math.PI*2.0);

      return new P3d( Math.sin(uang)*Math.cos(vang),
        Math.sin(vang),
        Math.cos(uang)*Math.cos(vang)
                ).mul(_radius) + _location;
    }
    
    P3d evalN(double u, double v) {
      double vang = Math.PI*(v*2-1)/2;
      double uang = (u*Math.PI*2);

      return new P3d( Math.sin(uang) * Math.cos(vang),
        Math.sin(vang),
        Math.cos(uang)*Math.cos(vang)
                );

    }

}