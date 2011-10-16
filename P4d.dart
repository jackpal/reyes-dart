class P4d {
  final double x,y,z,w;

/*  P4d(double xyzw)
  {
      x=y=z=w=xyzw;
  }
  P4d(double xyz,double ww)
  {
      x=y=z=w=xyz;
      w=ww;
  }
*/

  P4d(double xx,double yy,double zz, double ww) :
      x=xx,
      y=yy,
      z=zz,
      w=ww;
 
/*
  P4d(double xx, double yy, double zz)
  {
      x=xx;
      y=yy;
      z=zz;
      w=1;
  }

  P4d()
  {
      x=y=z=w=0;
  }
*/
  
  P4d operator+(P4d v) {return new P4d(x+v.x,y+v.y,z+v.z,w+v.w);} // add
  P4d add(double v)      {return new P4d(x+v,y+v,z+v,w+v);} // add
  P4d operator-(P4d v) {return new P4d(x-v.x,y-v.y,z-v.z,w-v.w);} // sub
  P4d sub(double v)      {return new P4d(x-v,y-v,z-v,w+v);} // sub
  P4d operator*(P4d v) {return new P4d(x*v.x,y*v.y,z*v.z,w*v.w);} // mul
  P4d mul(double v)      {return new P4d(x*v,y*v,z*v,w*v);} // mul
  P4d operator/(P4d v) {return new P4d(x/v.x,y/v.y,z/v.z,w/v.w);} // div
  P4d div(double v)      {return new P4d(x/v,y/v,z/v,w+v);} // div

  //void operator+=(P4d &v) { x=x+v.x; y=y+v.y; z=z+v.z; w=w+v.w; } // add
  //void operator+=(double v)      { x=x+v;   y=y+v;   z=z+v; w=w+v; } // add
  //void operator-=(P4d &v) { x=x-v.x; y=y-v.y; z=z-v.z; w=w-v.w; } // sub
  //void operator-=(double v)      { x=x-v;   y=y-v;   z=z-v; w=w-v;} // sub
  //void operator*=(P4d &v) { x=x*v.x; y=y*v.y; z=z*v.z;w=w*v.w; } // mul
  //void operator*=(double v)      { x=x*v;   y=y*v;   z=z*v; w=w*v;} // mul
  //void operator/=(P4d &v) { x=x/v.x; y=y/v.y; z=z/v.z; w=w/v.w;} // div
  //void operator/=(double v)      { x=x/v;   y=y/v;   z=z/v; w=w/v;} // div

  //friend P4d operator +(double v,P4d &m){ return P4d(v+m.x,v+m.y,v+m.z,v+m.w); }
  //friend P4d operator -(double v,P4d &m){ return P4d(v-m.x,v-m.y,v-m.z,v-m.w); }
  //friend P4d operator *(double v,P4d &m){ return P4d(v*m.x,v*m.y,v*m.z,v*m.w); }
  //friend P4d operator /(double v,P4d &m){ return P4d(v/m.x,v/m.y,v/m.z,v/m.w); }

  P4d operator negate() {return new P4d(-x,-y,-z,-w);}

  /*

  friend bool operator ==(P4d &n,P4d &m)
  {
      return (n.x==m.x && n.y==m.y && n.z==m.z && n.w==m.w);
  }


  friend bool operator != (P4d n,P4d m)
  {
      return !(n==m);
  }
  */

  double dist(P4d v2)
  {
      P4d v1= new P4d(x,y,z,w);
      P4d v=v1-v2;
      return Math.sqrt(v.x*v.x+v.y*v.y+v.z*v.z+v.w*v.w);
  }
}
