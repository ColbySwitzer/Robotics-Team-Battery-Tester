import processing.serial.*;
import processing.data.*;

JSONObject json = new JSONObject();
String filePath = "data/output.json";

Button CVESC_button, CV_button;

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

int buttonX, buttonY, buttonW = 100, buttonH = 40;
int buttonX_cvbutton, buttonY_cvbutton;
int buttonW_cvbutton = 150;

void setup() {
  size(1260, 640);
  initializeSerialPort();
  buttonX = width - 150 - buttonW/2;
  buttonY = 50 - buttonH/2;
  
  buttonX_cvbutton = width/2 + 100 - buttonW/2;
  buttonY_cvbutton = height/2+150 - buttonH/2;

  CVESC_button = new Button(buttonX, buttonY, buttonW, buttonH, "ESC");
  CV_button = new Button(buttonX, buttonY, buttonW, buttonH, "Current Voltage");
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
  if (keyCode == ENTER) {
    currentScreen = 0;
  }
}

void mousePressed() {
  if (CVESC_button.isMouseOver()) {
    CVESC_button.buttonClicked = true;
  }
  if(CV_button.isMouseOver()){
  CV_button.buttonClicked = true;
  }
}


void stop() {
  if (myPort != null) {
    myPort.stop();
  }
}
