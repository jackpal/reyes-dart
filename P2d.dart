class P2d {
    final double x;
    final double y;

    P2d(double xx, double yy) :
        x=xx, y=yy;

    P2d.zero() : x = 0.0, y = 0.0;

    P2d operator+(P2d v) {return new P2d(x+v.x,y+v.y);} // add
    P2d add(double v) {return new P2d(x+v,y+v);} // add
    P2d operator-(P2d v) {return new P2d(x-v.x,y-v.y);} // sub
    P2d sub(double v) {return new P2d(x-v,y-v);} // sub
    P2d operator*(P2d v) {return new P2d(x*v.x,y*v.y);} // mul
    P2d mul(double v) {return new P2d(x*v,y*v);} // mul
    P2d operator/(P2d v) {return new P2d(x/v.x,y/v.y);} // div
    P2d div(double v) {return new P2d(x/v,y/v);} // div

    bool operator > (P2d m)
    {
        return (x>m.x&&y>m.y);
    }

    
    bool operator < (P2d m)
    {
        return (x<m.x&&y<m.y);
    }

    bool operator >= (P2d m)
    {
        return (x>=m.x&&y>=m.y);
    }

    
    bool operator <= (P2d m)
    {
        return (x<=m.x&&y<=m.y);
    }

    double mag()
    {
        return x*x+y*y;
    }

    double sum()
    {
        return x+y;
    }

    double manhattan_distance(P2d v)
    {
        return (x-v.x).abs()+(y-v.y).abs();
    }

    P2d operator negate()
    {
        return new P2d(-x, -y);
    }
   
    P2d normalize()
    {
        double len;
        double nx = x;
        double ny = y;

        len=Math.sqrt(x*x+y*y);

        if (len!=0.0)
        {
            nx/=len;
            ny/=len;
        }

        return new P2d(nx,ny);
    }

    double dist(P2d v2)
    {
        P2d v1= new P2d(x,y);
        P2d v=v1-v2;
        return Math.sqrt(v.x*v.x+v.y*v.y);
    }


    double dot(P2d d)
    {
        return (x*d.x) + (y*d.y);
    }

    double length()
    {
        return Math.sqrt(x*x + y*y);
    }


    double cross(P2d d)
    {
        return (this.x*d.y) - (this.y*d.x);
    }


    double magnitude()
    {
        return (x*x + y*y);
    }
    
    bool operator==(P2d d) {
      return x == d.x && y == d.y;
    }
}

