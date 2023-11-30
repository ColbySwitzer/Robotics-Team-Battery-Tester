import processing.serial.*;
import processing.data.*;

JSONObject batteryProfiles = new JSONObject();
JSONObject json = new JSONObject();
String filePath = "data/output.json";
String batFilePath = "data/batteryProfiles.json";

Button ESC_button, CV_button, SV_button, increaseBatPro_button, decreaseBatPro_button;
int buttonX, buttonY, buttonW, buttonH, buttonX_cvbutton, buttonY_cvbutton, buttonW_cvbutton, buttonX_svbutton;

Serial myPort;
ArrayList<Float> dataPoints = new ArrayList<Float>();
ArrayList<Float> overlayPoints = new ArrayList<Float>();
boolean serialError;

boolean isGraphRunning = false;
float data;
float voltMin = 0.0;
float voltMax = 15.0;

int currentScreen = 0;
int batteryProfile = 1;
int amountBatPro;

void setup() {
  size(1260, 640);
  //initializeSerialPort();
  setupButtons();
  jsonInitialize();
}

void initializeSerialPort() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println(portName+" is initialized");
}

void setupButtons() {
  buttonX = width - 75 - buttonW/2;
  buttonY = 50 - buttonH/2;
  buttonW = 100;
  buttonH = 40;
  
  ESC_button = new Button(buttonX, buttonY, buttonW, buttonH, "ESC");

  buttonX_cvbutton = width/2 + 100 - buttonW/2;
  buttonY_cvbutton = height/2+150 - buttonH/2;
  buttonX_svbutton = width/2 - 100 - buttonW/2;

  
  CV_button = new Button(buttonX_cvbutton, buttonY_cvbutton, buttonW_cvbutton, buttonH, "Current Voltage");
  SV_button = new Button(buttonX_svbutton, buttonY_cvbutton, buttonW, buttonH, "Saved Data");

  int plusMinusButtonW = buttonW+20;
  int plusMinusButtonX = 100-plusMinusButtonW/2;
  int plusButtonY = 150;
  increaseBatPro_button = new Button(plusMinusButtonX, plusButtonY, plusMinusButtonW, buttonH, "Add Profile");
  decreaseBatPro_button = new Button(plusMinusButtonX, plusButtonY+buttonH+20, plusMinusButtonW, buttonH, "Delete Profile");
}

void jsonInitialize() {
  batteryProfiles = loadJSONObject(batFilePath);

  amountBatPro = batteryProfiles.getInt("Number of Battery Profiles");
  println("Retrieved Int: "+amountBatPro);
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
  if ( key == 'l') {
    ArrayList<Float> jsonArrayData = new ArrayList<Float>();
    JSONArray jsonArray = json.getJSONArray("Data Points");
    for (int i=0; i<jsonArray.size(); i++) {
      Float element = jsonArray.getFloat(i);
      jsonArrayData.add(element);
    }
    println(jsonArrayData);
    println("Pulled Array Successfully!");
  }
}

void mousePressed() {
  if (ESC_button.isMouseOver()) {
    ESC_button.buttonClicked = true;
  }
  if (CV_button.isMouseOver()) {
    CV_button.buttonClicked = true;
  }
  if (SV_button.isMouseOver()) {
    SV_button.buttonClicked = true;
  }
  if (increaseBatPro_button.isMouseOver()) {
    increaseBatPro_button.buttonClicked = true;
  }
  if (decreaseBatPro_button.isMouseOver()) {
    if (amountBatPro > 0 ) {
      decreaseBatPro_button.buttonClicked = true;
    }
  }
}


void exit() {
  if (myPort != null) {
    myPort.stop();
  }
  batteryProfiles.setInt("Number of Battery Profiles", amountBatPro);
  saveJSONObject(batteryProfiles, batFilePath);
}
