#library('reyes');

#import('dart:core');
#import('dart:dom');

#source("BoundingBox.dart");
#source("BoundSplit.dart");
#source("CanvasColorBuffer.dart");
#source("Color.dart");
#source("ColorBuffer.dart");
#source("Microgrid.dart");
#source("Micropolygon.dart");
#source("Noise.dart");
#source("P2d.dart");
#source("P3d.dart");
#source("P4d.dart");
#source("Projection.dart");
#source("Render.dart");
#source("Shade.dart");
#source("Shape.dart");
#source("Sphere.dart");
#source("SurfaceData.dart");
#source("Useful.dart");
#source("ZBuffer.dart");
#source("Viewport.dart");

// Notes:
// like lack of != operator
// not sure I like using dynamic code to implement overloading.

class reyes {

  reyes() {
  }
  
  void doRender(ColorBuffer screen) {
    Date start = new Date.now();
    
    Projection camera = new Projection();

    Queue<Shape> unsplit_shapes = new Queue<Shape>(); 
    Queue<Shape> split_shapes = new Queue<Shape>();
    
    int screenW = screen.width;
    int screenH = screen.height;

    ZBuffer zbuffer = new ZBuffer(screenW, screenH);
    zbuffer.clear();
	    screen.clear(new Color(0.0, 0.0, 1.0));

        double FOV = radians(60.0);
        camera.dx = (screen.width.toDouble()/2.0) / Math.tan(FOV/2.0);
        camera.dy = (screen.height.toDouble()/2.0) / Math.tan(FOV/2.0);
        camera.screenWidth = screenW.toDouble();
        camera.screenHeight = screenH.toDouble();


        Sphere s1 = new Sphere(new P3d(0.0, 0.0, 2.0), 0.6);
        unsplit_shapes.addLast(s1);

    /*  Sphere *s2 = new Sphere(p3d(-1.25,0,4), 0.6);
        unsplit_shapes.push_back(s2);
        

        Sphere *s3 = new Sphere(p3d(1.25,0,4), 0.6);
        unsplit_shapes.push_back(s3);*/


        boundSplit(unsplit_shapes, split_shapes, camera);

        render(split_shapes, camera, zbuffer, screen,
          () {
            Date end = new Date.now();
            Duration diff = end.difference(start);
            String message = 'done! elapsed time = $diff';
            log(message);
            // log doesn't seem to work on Firefox.
            print(message);
          });
  }

  void run() {
    HTMLCanvasElement canvas = document.getElementById('reyesCanvas');
    ColorBuffer colorBuffer = new CanvasColorBuffer(canvas);
    doRender(colorBuffer);
  }
  
}

void main() {
  new reyes().run();
}
