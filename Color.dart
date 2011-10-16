class Color
{
    final double r,g,b;

    const Color(double rr, double gg, double bb) :
        r=rr, g=gg, b=bb;

    Color.zero() : r= 0.0, g = 0.0, b = 0.0;


    Color operator+(Color v) {return new Color(r+v.r,g+v.g,b+v.b);} // add
    Color add(double v)      {return new Color(r+v,g+v,b+v);} // add
    Color operator-(Color v) {return new Color(r-v.r,g-v.g,b-v.b);} // sub
    Color sub(double v)      {return new Color(r-v,g-v,b-v);} // sub
    Color operator*(Color v) {return new Color(r*v.r,g*v.g,b*v.b);} // mul
    Color mul(double v)      {return new Color(r*v,g*v,b*v);} // mul
    Color operator/(Color v) {return new Color(r/v.r,g/v.g,b/v.b);} // div
    Color div(double v)      {return new Color(r/v,g/v,b/v);} // div

    /*void operator+=(Color v) { r=r+v.r; g=g+v.g; b=b+v.b; } // add
    void operator+=(double v)      { r=r+v;   g=g+v;   b=b+v; } // add
    void operator-=(Color v) { r=r-v.r; g=g-v.g; b=b-v.b; } // sub
    void operator-=(double v)      { r=r-v;   g=g-v;   b=b-v;} // sub
    void operator*=(Color v) { r=r*v.r; g=g*v.g; b=b*v.b; } // mul
    void operator*=(double v)      { r=r*v;   g=g*v;   b=b*v;} // mul
    void operator/=(Color v) { r=r/v.r; g=g/v.g; b=b/v.b; } // div
    void operator/=(double v)      { r=r/v;   g=g/v;   b=b/v; } // div
    void operator=(double v)      { r=g=b=v; }
    */

    //friend Color operator +(double v,Color &m){ return Color(v+m.r,v+m.g,v+m.b); }
    //friend Color operator -(double v,Color &m){ return Color(v-m.r,v-m.g,v-m.b); }
    //friend Color operator *(double v,Color &m){ return Color(v*m.r,v*m.g,v*m.b); }
    //friend Color operator /(double v,Color &m){ return Color(v/m.r,v/m.g,v/m.b); }

    Color pow(double v)
    {
        return new Color(
          Math.pow(r,v),
          Math.pow(g,v),
          Math.pow(b,v));
    }

    Color clamp()
    {
      return new Color(Math.min(r, 1.0),
        Math.min(g, 1.0),
        Math.min(b, 1.0));
    }

    bool operator ==(Color m)
    {
        return (r == m.r && g == m.g && b == m.b);
    }
}
