class ZBuffer {
   List<double> _zb;
  int _w, _h;
  
  ZBuffer(int w, int h) {
    _w = w;
    _h = h;
    _zb = new List<double>(_w * _h);
  }
  
  void clear() {
    int count = _w * _h;
    for (int i = 0; i < count; i++) {
      _zb[i] = 1e10;
    }
  }
  
  double getZ(int x, int y) {
    return _zb[x + y * _w];
  }

  double setZ(int x, int y, double d) {
    _zb[x + y * _w] = d;
  }
}