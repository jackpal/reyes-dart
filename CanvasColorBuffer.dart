

class CanvasColorBuffer extends ColorBuffer {
  HTMLCanvasElement _canvas;
  CanvasRenderingContext2D _context;
  
  CanvasColorBuffer(HTMLCanvasElement canvas) :
    super(canvas.width, canvas.height),
    _canvas = canvas, _context = canvas.getContext('2d');

  void setPixel(int x, int y, Color c) {
    _context.setFillColor(c.r, c.g, c.b, 1.0);
    _context.fillRect(x, y, 1, 1);
  }
  
  void clear(Color c) {
    _context.setFillColor(c.r, c.g, c.b, 1.0);
    _context.fillRect(0, 0, _canvas.width, _canvas.height);
  }
  
  void flush() {}
}
