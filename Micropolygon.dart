class Micropolygon {
  P3d _v0, _v1, _v2, _v3;
  P3d _normal;

  Color c;
  double o; // opacity

  Micropolygon(P3d p0, P3d p1, P3d p2, P3d p3, P3d nn, Color cc, double oo) :
    _v0 = p0,
    _v1 = p1,
    _v2 = p2,
    _v3 = p3,
    _normal = nn,
    c = cc,
    o = oo;

  bool sample(double x, double y) {
    if(((y - _v0.y) * (_v0.x - _v1.x) - (x - _v0.x) * (_v0.y - _v1.y)) < 0)
      return false;

  if(((y - _v1.y) * (_v1.x - _v2.x) - (x - _v1.x) * (_v1.y - _v2.y)) < 0)
      return false;

  if(((y - _v2.y) * (_v2.x - _v3.x) - (x - _v2.x) * (_v2.y - _v3.y)) < 0)
      return false;

  if(((y - _v3.y) * (_v3.x - _v0.x) - (x - _v3.x) * (_v3.y - _v0.y)) < 0)
      return false;

  return true;
  }

  void rasterize(ZBuffer zbuffer, ColorBuffer screen) {
    double minx = Math.min( Math.min(_v0.x, _v1.x), Math.min(_v2.x, _v3.x)).floor();
    double maxx = Math.max( Math.max(_v0.x, _v1.x), Math.max(_v2.x, _v3.x)).ceil();

    double miny = Math.min( Math.min(_v0.y, _v1.y), Math.min(_v2.y, _v3.y)).floor();
    double maxy = Math.max( Math.max(_v0.y, _v1.y), Math.max(_v2.y, _v3.y)).ceil();

    for (double y = miny; y < maxy; y++)
    {
        for (double x = minx; x < maxx; x++) 
        {
            if (sample(x,y))
            {
                int sx = (x+screen.width/2).toInt();
                int sy = (y+screen.height/2).toInt();
                if (sx >= 0 && sx < screen.width && sy >= 0 && sy < screen.height) {
                    if (_v0.z < zbuffer.getZ(sx, sy)) {
                        screen.setPixel(sx, sy, c);
                        zbuffer.setZ(sx, sy, _v0.z);
                    }
                }
            }
        }
    }

  }
}
