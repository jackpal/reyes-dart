class CanvasColorBuffer2 extends ColorBuffer {
  HTMLCanvasElement _canvas;
  CanvasRenderingContext2D _context;
  ImageData _imageData;
  
  CanvasColorBuffer2(HTMLCanvasElement canvas) :
    super(canvas.width, canvas.height),
    _canvas = canvas, _context = canvas.getContext('2d') {
    _imageData = _context.createImageData(width, height);
  }
  
  // fails because ImageData.data[]= is not implemented yet.
  void setPixel(int x, int y, Color c) {
    int base = 4 * (x + y * width);
    _imageData.data[base] = (c.r * 255.0).toInt();
    _imageData.data[base + 1] = (c.g * 255.0).toInt();
    _imageData.data[base + 2] = (c.b * 255.0).toInt();
    _imageData.data[base + 3] = 255;
  }
  
  void flush() {
    _context.putImageData(_imageData, 0, 0);
  }
}
