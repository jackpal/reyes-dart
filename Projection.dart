class Projection {
  // TODO: add a cameraMatrix
  double dx,dy;
  double screenWidth;
  double screenHeight;

  Projection(){}
  P2d project(P3d p) {
    if (p.z == 0) {
      return new P2d.zero();
    }
    return new P2d((dx * p.x) / p.z, (dy * p.y) / p.z);
  }

  double rasterEstimate(P3d p1, P3d p2) {
    return project(p1).dist(project(p2));
  }

}