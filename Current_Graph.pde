void readSerialPort() {
  if (isGraphRunning) {
    if (myPort != null && myPort.available() > 0) {
      String data = myPort.readStringUntil('\n');
      if (data != null && data != "NaN") {
        float sensorValue = float(data.trim());
        println(sensorValue);
        if (dataPoints.size() >= 10) {
          dataPoints.remove(0);
        }
        dataPoints.add(sensorValue);
        overlayPoints.add(sensorValue);
        JSONArray JSONdataPoints = new JSONArray();
        for (float f : overlayPoints) {
          JSONdataPoints.append(f);
        }
        batteryData.setJSONArray(str(currentBatteryProfile), JSONdataPoints);
        saveJSONObject(batteryData, filePath);
      }
    }
  }
}
