import processing.serial.*;
import processing.data.*;

JSONObject json = new JSONObject();
String filePath = "data/output.json";

Serial myPort;
ArrayList<Float> dataPoints = new ArrayList<Float>();
ArrayList<Float> overlayPoints = new ArrayList<Float>();
boolean serialError;
boolean isGraphRunning = false;
float data;
float voltMin = 0.0;
float voltMax = 15.0;
int currentScreen = 1;
int batteryProfile = 1;

void setup() {
  size(1260, 640);
  initializeSerialPort();
}

void initializeSerialPort() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println(portName+" is initialized");
}

void draw() {
  screenManagement();
}

void keyPressed() {
  if (key == ' ' && currentScreen == 1) {
    // Toggle the isGraphRunning variable when spacebar is pressed
    isGraphRunning = !isGraphRunning;
    println("isGraphRunning: " + isGraphRunning);
  }
  if (key == 'b') {
    println(dataPoints);
    println(overlayPoints);
  }
  if (key == 's' && currentScreen == 1) {
    JSONArray JSONdataPoints = new JSONArray();
    for (float f : overlayPoints) {
      JSONdataPoints.append(f);
    }

    json.setJSONArray("Data Points", JSONdataPoints);
    saveJSONObject(json, filePath);
    println("JSON file created and data saved!");
  }
  if ( key == 'l' /*&&   currentScreen == 2*/) {
    ArrayList<Float> jsonArrayData = new ArrayList<Float>();
    JSONArray jsonArray = json.getJSONArray("Data Points");
    for (int i=0; i<jsonArray.size(); i++) {
      Float element = jsonArray.getFloat(i);
      jsonArrayData.add(element);
    }
    println(jsonArrayData);
    println("Pulled Array Successfully!");
  }
  if (key == '1' && !isGraphRunning && currentScreen == 1) {
    batteryProfile = 1;
  }
  if (key == '2' && !isGraphRunning && currentScreen == 1) {
    batteryProfile = 2;
  }
  if (key == '3' && !isGraphRunning && currentScreen == 1) {
    batteryProfile = 3;
  }
  if(keyCode == ENTER){
  currentScreen = 0;
  }
}

void stop() {
  if (myPort != null) {
    myPort.stop();
  }
}
