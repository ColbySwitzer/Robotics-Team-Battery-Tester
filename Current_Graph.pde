void currentGraphDisplay() {
  float squareHeight = 400;
  float squareWidth = 600;
  float squareSize = 400; // Width and height of the square
  float squareX = (width - squareSize) / 2; // X-coordinate of the top-left corner of the square
  float squareY = (height - squareSize) / 2; // Y-coordinate of the top-left corner of the square
  //fill(0); // Set fill color to black
  noFill();
  rect(squareX, squareY, squareSize, squareSize);

  // Translate the origin to the center of the square
  translate(squareX + squareSize / 2, squareY + squareSize / 2);

  if (isGraphRunning) {
    if (myPort != null && myPort.available() > 0) {
      String data = myPort.readStringUntil('\n');
      if (data != null && data != "NaN") {
        float sensorValue = float(data.trim());

        println(sensorValue);
        if (dataPoints.size() >= 10) {
          // Remove the oldest value if there are already 10 values in the dataPoints ArrayList
          dataPoints.remove(0);
        }
        dataPoints.add(sensorValue);
        overlayPoints.add(sensorValue);
      }
    }
  }
  noFill();
  strokeWeight(2);
  beginShape();
  for (int i=0; i < dataPoints.size(); i++) {
    float x = map(i, 0, dataPoints.size()-1, -squareHeight/2, squareHeight/2);
    float y = map(dataPoints.get(i), 0, 1023, squareHeight/2, -squareHeight/2);
    vertex(x, y);
  }
  endShape();
}


void savedGraphDisplay(){

}
