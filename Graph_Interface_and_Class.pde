interface Graph {
  int graphWidth = 700;
  int graphHeight = 500;
  int voltMin = 0;
  int voltMax = 24;
  void draw(ArrayList<Float> x);
}



class currentGraph implements Graph {

  currentGraph() {
  }

  void draw(ArrayList<Float> currentDataPoints) {
    float graphX = (width-graphWidth)/2;
    float graphY = (height-graphHeight)/2;
    noFill();
    rect(graphX, graphY, graphWidth, graphHeight);
    translate(graphX+graphWidth/2, graphY+graphHeight /2);
    
    noFill();
    strokeWeight(2);
    beginShape();
    for (int i=0; i < currentDataPoints.size(); i++) {
      float x = map(i, 0, currentDataPoints.size()-1, -graphHeight/2, graphHeight/2);
      float y = map(currentDataPoints.get(i), voltMin, voltMax, graphHeight/2, -graphHeight/2);
      vertex(x, y);
    }
    endShape();
  }
}


class savedGraph implements Graph {

  savedGraph() {
  }

  void loadGraph(int batteryProfile, String JSONFilePath, JSONObject file) {
  }


  void draw(ArrayList<Float> savedDataPoints) {
    float graphX = (width-graphWidth)/2;
    float graphY = (height-graphHeight)/2;
    noFill();
    rect(graphX, graphY, graphWidth, graphHeight);
    translate(graphX+graphWidth/2, graphY+graphHeight /2);
    
    noFill();
    strokeWeight(2);
    beginShape();
    for (int i=0; i < savedDataPoints.size(); i++) {
      float x = map(i, 0, savedDataPoints.size()-1, -graphHeight/2, graphHeight/2);
      float y = map(savedDataPoints.get(i), 0, 1023, graphHeight/2, -graphHeight/2);
      vertex(x, y);
    }
    endShape();
  }
}
