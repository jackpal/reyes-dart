void displace(Microgrid grid)
{
  return;
    for (int u=0; u < grid.w; u++) {
        for (int v=0; v < grid.h; v++) {
            P3d vert = grid.getVertex(u,v);
            P3d n = grid.getNormal(u,v);
            
            //if(vert.y<-0.5f)
            //  vert+=n*2.f;
        
            double cu = grid.u(u);
            double cv = grid.v(v);
            double disp = Math.sin(cv*100)* Math.cos(cu*100)*.1;//turb(cu*25,cv*25, 0.5, 28);

            if(disp<0.5)
                vert-=n.mul(disp*0.2);
            else
                vert-=n.mul(0.5*0.2);

            grid.setVertex(u,v, vert);
        }
    }

    grid.recomputNormals();
}


double eval(double r, double i)
{
    
    double   a = r,
            b = i,
            t;

    for (int it=0;it<256;it++)
    {
        // if(stop)
        //    break;

        t=a*a - b*b + r;
        b=2.0*a*b + i;
        a=t;

        if(a*a + b*b>4.0)
            return(it/256.0);

    }

    return 1.0;
}



void shade(Microgrid grid)
{
    for (int u=0; u<grid.w-1; u++)
    {
        for (int v=0; v<grid.h-1; v++)
        {
            P3d n = grid.getNormal(u,v);

            //if(u>=grid->W()-3||v>=grid->H()-3)
            double cu = (grid.u(u)*30).floor();
            double cv = (grid.v(v)*15).floor();
        
            bool checker = (((cv.toInt() ^ cu.toInt()) & 1) == 1);
            Color s = checker ? new Color(0.0,0.0,0.0) : new Color(1.0,1.0,1.0);

            //if(u>=grid->W()-3||v>=grid->H()-3)
            //  s = Colour(1,0,0);

            Color c = s.mul(Math.max(0.2,n.dot(new P3d(1.0,1.0,-1.0).normalize())));

            grid.setColor(u,v,c);

        }
    }
}

