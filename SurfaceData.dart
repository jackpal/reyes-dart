class SurfaceData {
  final double startU, endU;
  final double startV, endV;
  final int generation;
  int maxU, maxV;
  
  SurfaceData(double startU, double endU, double startV, double endV, int generation) :
    startU = startU,
    endU = endU,
    startV = startV,
    endV = endV,
    generation = generation,
    maxU = 0,
    maxV = 0;
  
  SurfaceData.whole() : 
    startU = 0.0,
    endU = 1.0,
    startV = 0.0,
    endV = 1.0,
    generation = 0,
    maxU = 0,
    maxV = 0;
 
  
  factory SurfaceData.split(SurfaceData parent, bool splitV, bool firstChild) {
    double startU, endU, startV, endV;
    if (splitV) {
      double split = parent.startV + (parent.endV-parent.startV) / 2.0;
      startU = parent.startU;
      endU = parent.endU;
      if (firstChild) {
         startV = parent.startV;
         endV = split;
      } else {
        startV = split;
        endV = parent.endV;
      }
    } else {   
      double split = parent.startU + (parent.endU - parent.startU) / 2.0;
      startV = parent.startV;
      endV = parent.endV;
      if (firstChild) {
        startU = parent.startU;
        endU = split;
      } else {
        startU = split;
        endU= parent.endU;
      }
    }
    SurfaceData result = new SurfaceData(startU, endU, startV, endV, parent.generation+1);
    result.maxU = parent.maxU;
    result.maxV = parent.maxV;
    return result;
  }
}
