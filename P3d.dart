class P3d {
    final double x,y,z;

    const P3d(double xx,double yy,double zz) :
        x=xx,
        y=yy,
        z=zz;
    
    const P3d.fromDouble(double v) :
      x = v,
      y = v,
      z = v;


    P3d operator+(P3d v) {return new P3d(x+v.x,y+v.y,z+v.z);} // add
    P3d add(double v)      {return new P3d(x+v,y+v,z+v);} // add
    P3d operator-(P3d v) {return new P3d(x-v.x,y-v.y,z-v.z);} // sub
    P3d sub(double v)      {return new P3d(x-v,y-v,z-v);} // sub
    P3d operator*(P3d v) {return new P3d(x*v.x,y*v.y,z*v.z);} // mul
    P3d mul(double v)      {return new P3d(x*v,y*v,z*v);} // mul
    P3d operator/(P3d v) {return new P3d(x/v.x,y/v.y,z/v.z);} // div
    P3d div(double v)      {return new P3d(x/v,y/v,z/v);} // div

    /*
    void operator+=(P3d v) { x=x+v.x; y=y+v.y; z=z+v.z; } // add
    void operator+=(double v)      { x=x+v;   y=y+v;   z=z+v; } // add
    void operator-=(P3d v) { x=x-v.x; y=y-v.y; z=z-v.z; } // sub
    void operator-=(double v)      { x=x-v;   y=y-v;   z=z-v;} // sub
    void operator*=(P3d v) { x=x*v.x; y=y*v.y; z=z*v.z; } // mul
    void operator*=(double v)      { x=x*v;   y=y*v;   z=z*v;} // mul
    void operator/=(P3d v) { x=x/v.x; y=y/v.y; z=z/v.z; } // div
    void operator/=(double v)      { x=x/v;   y=y/v;   z=z/v; } // div
    */
    //friend P3d operator +(double v,P3d m){ return P3d(v+m.x,v+m.y,v+m.z); }
    //friend P3d operator -(double v,P3d m){ return P3d(v-m.x,v-m.y,v-m.z); }
    //friend P3d operator *(double v,P3d m){ return P3d(v*m.x,v*m.y,v*m.z); }
    //friend P3d operator /(double v,P3d m){ return P3d(v/m.x,v/m.y,v/m.z); }

    P3d operator negate() {return new P3d(-x,-y,-z);}  
/*
    friend bool operator == (P3d n,P3d m)
    {
        if(n.x==m.x&&n.y==m.y&&n.z==m.z)
            return true;

        return false;
    }


    friend bool operator != (P3d n,P3d m)
    {
        if(n.x==m.x&&n.y==m.y&&n.z==m.z)
            return false;

        return true;
    }
*/

    double dot(P3d v)
    {
        return x * v.x +  y * v.y + z * v.z;
    }

    P3d cross(P3d v)
    {
        return new P3d(
                    y*v.z-z*v.y,
                    z*v.x-x*v.z,
                    x*v.y-y*v.x);
    }

    P3d faceforward(P3d I)
    {
        if (this.dot(I)>0) {
            return new P3d(-x, -y, -z);
        }
        return this;
    }

    P3d normalize()
    {
        double len = x*x+y*y+z*z;
        double nx = x;
        double ny = y;
        double nz = z;

        if (len>0) {
            len = Math.sqrt(len);
        }
        
        if (len!=0.0)
        {
            double mul = 1.0/len;
            nx*=mul;
            ny*=mul;
            nz*=mul;
        }

        return new P3d(nx,ny,nz);
    }


    double dist(P3d v2)
    {
        P3d v = this-v2;
        return Math.sqrt(v.x*v.x+v.y*v.y+v.z*v.z);
    }

    double distXY(P3d v2)
    {
        double dx = x - v2.x;
        double dy = y - v2.y;
        return Math.sqrt(dx * dx + dy * dy);
    }
    
    /* Return the distance squared, in just x, y */
    double distXY2(P3d v2)
    {
        double dx = x - v2.x;
        double dy = y - v2.y;
        return dx * dx + dy * dy;
    }
    
    double length()
    {
        return Math.sqrt(x*x + y*y + z*z);
    }

    double magnitude()
    {
        return (x*x + y*y + z*z);
    }

    bool operator==(P3d d) {
        return x == d.x && y == d.y && z == d.z;
    }
}
