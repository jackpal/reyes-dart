class ColorBuffer {
  final int width;
  final int height;
  
  ColorBuffer(int w, int h) : width = w, height = h;
  
  abstract void setPixel(int x, int y, Color c);
  abstract void flush();

  void clear(Color c) {
    for (int j=0;j<height;j++) {
      for (int i=0;i<width;i++) {
                setPixel(i,j, c);
            }
        }
  }
}
