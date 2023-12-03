void readSerialPort() {
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
}
