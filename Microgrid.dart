class Microgrid {
    List<P3d> _vertices;
	List<P3d> _normals;
	List<Color> _colors;
	int _w, _h;

	double startU, endU, startV, endV;

	Microgrid() {}

	int get w() => _w;
	int get h() => _h;

	void allocate(int ww, int hh) {    
        _w = ww;
        _h = hh;
    
        int count = _w * _h;
        _vertices = _createP3d(count);
        _normals = _createP3d(count);
        _colors = _createColors(count);
	}
	
	List<P3d> _createP3d(int count) {
	  List<P3d> l = new List<P3d>(count);
	  //for (int i = 0; i < count; i++) {
	  //  l[i] = new P3d();
	  //}
	  return l;
	}
	
	List<Color> _createColors(int count) {
	  List<Color> l = new List<Color>(count);
	  //for (int i = 0; i < count; i++) {
	  //  l[i] = new color();
	  //}
	  return l;
	}
	
	void clear() {
	  _w = 0;
	  _h = 0;
	  _vertices = null;
	  _normals = null;
	  _colors = null;
	}
	
	bool _bounds(int x, int y) {
	  return x >= 0 && x < _w && y >= 0 && y < _h;
	}
	
	void _error(int x, int y) {
	  throw new Exception("bounds out of range");
	}
	
	int _array(int x, int y) {
	  return x + _w * y;
    }
    
	void setVertex(int x, int y, P3d v) {
	    if (_bounds(x, y)) {
	        _vertices[_array(x, y)] = v;
	    } else {
	      _error(x, y);
	    }
	}
	
	void setNormal(int x, int y, P3d n) {
	    if (_bounds(x, y)) {
	        _normals[_array(x, y)] = n;
	    } else {
        _error(x, y);
      }
	}
	
	void setColor(int x, int y, Color c){
	    if (_bounds(x, y)) {
	        _colors[_array(x, y)] = c;
	    } else {
        _error(x, y);
      }
	}
	
	P3d getVertex(int x, int y){
	    if (_bounds(x, y)) {
	        return _vertices[_array(x, y)];
	    } else {
        _error(x, y);
      };
	}
	
	P3d getNormal(int x, int y){
	    if (_bounds(x, y)) {
	        return _normals[_array(x, y)];
	    } else {
        _error(x, y);
      };
	}
	
	Color getColor(int x, int y){
	    if (_bounds(x, y)) {
	        return _colors[_array(x, y)];
	    } else {
        _error(x, y);
      };
	}

	void project(Projection camera){
	  int count = _w * _h;
	  for (int i = 0; i < count; i++) {
	      P3d v = _vertices[i];
	      P2d pv = camera.project(v);
	      _vertices[i] = new P3d(pv.x, pv.y, v.z);
	  }
	}

	double u(int u) {
	  return _lerp(startU, endU, u, _w);
	}
	
	double v(int v) {
      return _lerp(startV, endV, v, _h);
	}
	
	double _lerp(double start, double end, int i, int maxi) {
	  double unit = i.toDouble() / (maxi - 1).toDouble();
	  return start + (end - start) * unit;
	}

	BoundingBox getBoundingBox() {
	  double minx = 0.0;
	  double miny = 0.0;
	  double minz = 0.0;
      double maxx = 0.0;
      double maxy = 0.0;
      double maxz = 0.0;
	  int count = _w * _h;
	  if (count > 0) {
	    P3d v = _vertices[0];
	    minx = v.x;
	    miny = v.y;
	    minz = v.z;
	    maxx = v.x;
	    maxy = v.y;
	    maxz = v.z;
	  }
	  for (int i = 1; i < count; i++) {
	      P3d v = _vertices[i];
          minx = Math.min(minx, v.x);
          miny = Math.min(miny, v.y);
          minz = Math.min(minz, v.z);
          maxx = Math.max(maxx, v.x);
          maxy = Math.max(maxy, v.y);
          maxz = Math.max(maxz, v.z);
	  }
	  return new BoundingBox(new P3d(minx, miny, minz), new P3d(maxx, maxy, maxz));
	}
	
	/* Estimate the raster size of the whole grid, the grid has already been projected
	 */
	P2d rasterEstimate() {
	  // Keep in squared value, only sqrt at end
	  double max_u=0.0, max_v=0.0;

    for (int u=0; u<w-1; u++) {
        for (int v=0; v<h-1; v++) {
            P3d v1 = getVertex(u,v);
            if (v1.z > 0.01) {
                P3d v2 = getVertex(u+1,v),
                    v3 = getVertex(u,v+1);
                
                max_u = Math.max(max_u, v1.distXY2(v2));
                max_v = Math.max(max_v, v1.distXY2(v3));
            }
        }
    }

    return new P2d(Math.sqrt(max_u)*w, Math.sqrt(max_v)*h);
	}

	void bust(List<Micropolygon> polys) {
        for(int u=0; u<_w-1; u++)
        {
            for(int v=0; v<_h-1; v++)
            {
              P3d a = getVertex(u, v);
              P3d b = getVertex(u + 1, v);
              P3d c = getVertex(u + 1, v + 1);
              P3d d = getVertex(u, v + 1);
                 Micropolygon poly = new Micropolygon(
                   a, b, c, d,
                   getNormal(u, v), getColor(u, v), 0.0);      
                 polys.addLast(poly);
            }
        }
	}

	void recomputNormals() {
	  for(int u=0; u<_w-1; u++) {
        for(int v=0; v<_h-1; v++)
        {
            P3d v1 = (getVertex(u,v)-getVertex(u+1,v));
            P3d v2 = (getVertex(u,v)-getVertex(u,v+1));

            setNormal(u,v,v1.cross(v2).normalize());
        }
    }
	}
	
	// Wavefront obj format. For some reason Blender doesn't like this.
	String toObj() {
	  StringBuffer sb = new StringBuffer();
	  int vertexCount = _w * _h;
      int faceCount = (_w-1) * (_h-1);
      sb.add('# microgrid in obj format\n');
      sb.add('# $_w x $_h\n');
      sb.add('# $vertexCount vertices, $faceCount faces\n');
     for (int i = 0; i < vertexCount; i++) {
       P3d v = _vertices[i];
       double x = v.x;
       double y = v.y;
       double z = v.z;
       sb.add("v $x $y $z\n");
     }
   for (int i = 0; i < vertexCount; i++) {
     P3d v = _normals[i];
     double x = v.x;
     double y = v.y;
     double z = v.z;
     sb.add("vn $x $y $z\n");
   }
     for (int u=0; u<_w-1; u++) {
       for (int v=0; v<_h-1; v++) {
         int a = u + v * _w;
         int b = (u + 1) + v * _w;
         int c = u + (v + 1) * _w;
         int d = (u + 1) + (v + 1) * _w;
         sb.add("f $a//$a $b//$b $c//$c\n");
         // sb.add("f $a//$a $b//$b $c//$c $d//$d\n");
       }
     }
     return sb.toString();
   }
	
	// Stanford ply format
    String toPly() {
	  StringBuffer sb = new StringBuffer();
	  int vertexCount = _w * _h;
      int faceCount = (_w-1) * (_h-1);
      sb.add('ply\n');
      sb.add('format ascii 1.0\n');
      sb.add('comment micropolygon in ply format\n');
      sb.add('comment $_w x $_h\n');
      sb.add('comment # $vertexCount vertices, $faceCount faces\n');
      sb.add('element vertex $vertexCount\n');
      sb.add('property double x\n');
      sb.add('property double y\n');
      sb.add('property double z\n');
      sb.add('element face $faceCount\n');
      sb.add('property list uint8 int32 vertex_index\n');
      sb.add('end_header\n');
     for (int i = 0; i < vertexCount; i++) {
       P3d v = _vertices[i];
       double x = v.x;
       double y = v.y;
       double z = v.z;
       sb.add("$x $y $z\n");
     }
   if (false) {
	   for (int i = 0; i < vertexCount; i++) {
		 P3d v = _normals[i];
		 double x = v.x;
		 double y = v.y;
		 double z = v.z;
		 sb.add("$x $y $z\n");
	   }
	}
     for (int u=0; u<_w-1; u++) {
       for (int v=0; v<_h-1; v++) {
         int a = u + v * _w;
         int b = (u + 1) + v * _w;
         int c = (u + 1) + (v + 1) * _w;
         int d = u + (v + 1) * _w;
         sb.add("4 $a $b $c $d\n");
       }
     }
     return sb.toString();
   }

}
