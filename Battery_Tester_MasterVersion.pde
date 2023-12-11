import processing.serial.*;
import processing.data.*;
import java.io.File;

JSONObject profileFile;
JSONObject dataFile;
String dataFilePath = "data/output.json";
String profileFilePath = "data/batteryProfiles.json";

ArrayList<JSONObject> batteryProfileData = new ArrayList<>();




ArrayList<Button> buttons = new ArrayList<>();
Button escapeButton, currentVoltageButton, savedVoltageButton, increaseBatPro_button, decreaseBatPro_button, increaseCurrentBatteryProfileButton, decreaseCurrentBatteryProfileButton, settingsButton;
currentGraph cg;
savedGraph sg;
Serial myPort;
boolean serialError;

ArrayList<Float> dataPoints = new ArrayList<Float>();
ArrayList<Float> overlayPoints = new ArrayList<Float>();

boolean isGraphRunning = false;
int currentScreen = 0;
int amountBatPro;
int currentBatteryProfile;

void setup() {
  size(1260, 640);
  //initializeSerialPort();
  initializeGraphs();
  setupButtons();
  jsonInitialize();
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

    //batteryData.setJSONArray(str(currentBatteryProfile), JSONdataPoints);
    //saveJSONObject(batteryData, filePath);
    println("JSON file created and data saved!");
  }
  if ( key == 'l') {
    ArrayList<Float> jsonArrayData = new ArrayList<Float>();
    //JSONArray jsonArray = batteryData.getJSONArray("Data Points");
    //for (int i=0; i<jsonArray.size(); i++) {
    //  Float element = jsonArray.getFloat(i);
    // jsonArrayData.add(element);
    //}
    //println(jsonArrayData);
    //println("Pulled Array Successfully!");
  }
}

void mousePressed() {
  isMouseOverCalls();
}


void exit() {
  closePort();
  saveDataOnClose();
}

// ########################################################### SETUP METHODS ########################################################### \\
void initializeSerialPort() {
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  println(portName+" is initialized");
}

void setupButtons() {
  int escapeButtonW = 100;
  int escapeButtonH = 40;
  int escapeButtonX = width - 55 - escapeButtonW/2;
  int escapeButtonY = 25 - escapeButtonH/2;

  escapeButton = new Button(escapeButtonX, escapeButtonY, escapeButtonW, escapeButtonH, "ESC");

  int currentVoltageButtonW = 140;
  int currentVoltageButtonH = escapeButtonH;
  int currentVoltageButtonX = width/2 + 100 - currentVoltageButtonW/2;
  int currentVoltageButtonY = height/2+150 - currentVoltageButtonH/2;
  int savedVoltageButtonX = width/2 - 100 - currentVoltageButtonW/2;

  currentVoltageButton = new Button(currentVoltageButtonX, currentVoltageButtonY, currentVoltageButtonW, currentVoltageButtonH, "Current Voltage");
  savedVoltageButton = new Button(savedVoltageButtonX, currentVoltageButtonY, currentVoltageButtonW, currentVoltageButtonH, "Saved Data");

  int addminusBatteryProfileButtonsW = 120;
  int addminusBatteryProfileButtonsH = 40;
  int addminusBatteryProfileButtonsX = 45;
  int addminusBatteryProfileButtonsY = 200;

  increaseBatPro_button = new Button(addminusBatteryProfileButtonsX, addminusBatteryProfileButtonsY, addminusBatteryProfileButtonsW, addminusBatteryProfileButtonsH, "Add Profile");
  decreaseBatPro_button = new Button(addminusBatteryProfileButtonsX, addminusBatteryProfileButtonsY+50, addminusBatteryProfileButtonsW, addminusBatteryProfileButtonsH, "Delete Profile");

  int swapCurrentBatteryProfileButtonW = 40;
  int swapCurrentBatteryProfileButtonH = 40;
  int swapCurrentBatteryProfileButtonX = 45;
  int swapCurrentBatteryProfileButtonY = 140;

  increaseCurrentBatteryProfileButton = new Button(swapCurrentBatteryProfileButtonX+swapCurrentBatteryProfileButtonW+10, swapCurrentBatteryProfileButtonY, swapCurrentBatteryProfileButtonW, swapCurrentBatteryProfileButtonH, "+");
  decreaseCurrentBatteryProfileButton = new Button(swapCurrentBatteryProfileButtonX, swapCurrentBatteryProfileButtonY, swapCurrentBatteryProfileButtonW, swapCurrentBatteryProfileButtonH, "-");


  int settingsButtonW = 100;
  int settingsButtonH = 40;
  int settingsButtonX = width/2;
  int settingsButtonY = height/2+100;

  settingsButton = new Button(settingsButtonX, settingsButtonY, settingsButtonW, settingsButtonH, "Settings");

  buttons.add(escapeButton);
  buttons.add(currentVoltageButton);
  buttons.add(savedVoltageButton);
  buttons.add(increaseBatPro_button);
  buttons.add(decreaseBatPro_button);
  buttons.add(increaseCurrentBatteryProfileButton);
  buttons.add(decreaseCurrentBatteryProfileButton);
  buttons.add(settingsButton);
}

void jsonInitialize() {

  File profileFileFinder = new File(sketchPath(profileFilePath));

  if (profileFileFinder.exists()) {
    profileFile = loadJSONObject(profileFilePath);
  } else {
    profileFile = new JSONObject();
    profileFile.setInt("numProfiles", 0);
    profileFile.setString("currentProfile", "");
    saveJSONObject(profileFile, profileFilePath);
  }

  File dataFileFinder = new File(sketchPath(dataFilePath));

  if (dataFileFinder.exists()) {
    dataFile = loadJSONObject(dataFilePath);
  } else {
    dataFile = new JSONObject();
    dataFile.setJSONObject("profiles",new JSONObject());
    saveJSONObject(dataFile, dataFilePath);
  }
}

void batteryProfileInitialize() {
  for (int i=0; i<amountBatPro; i++) {
    JSONObject batteryProfile = new JSONObject();
    batteryProfile.setInt("Nunmber of Tests: ", 0);
    JSONArray profileArray = new JSONArray();
    batteryProfile.setJSONArray("Test", profileArray);
  }
}

void initializeGraphs() {
  cg = new currentGraph();
  sg = new savedGraph();
}

// ########################################################### MOUSE PRESSED METHODS ########################################################### \\
void isMouseOverCalls() {
  for (Button button : buttons) {
    button.mousePressed();
  }
}

// ########################################################### EXIT METHODS ########################################################### \\
void closePort() {
  if (myPort != null) {
    myPort.stop();
  }
}

void saveDataOnClose() {
}
