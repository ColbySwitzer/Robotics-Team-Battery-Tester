
void screenManagement() {
  switch (currentScreen) {
  case 0:
    startScreen();
    break;
  case 1:
    currentVoltageScreen();
    break;
  case 2:
    savedDataScreen();
    break;
    case 3:
    settingsScreen();
    break;
  default:
    currentScreen = 0;
  }
}



void startScreen() {
  background(255);
  fill(24, 27, 122);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("Battery Tester Program", width/2, height/4);
  text("Please make sure your arduino is connected", width/2, height/4+70);
  currentVoltageButton();
  savedVoltageButton();
}

void currentVoltageScreen() {
  background(255);
  batteryProfile();
  ESCAPEbutton();
  text("Graph Running: "+isGraphRunning, 150, 50);
  readSerialPort();
  cg.draw(dataPoints);
}

void savedDataScreen() {
  background(255);
  batteryProfile();
  ESCAPEbutton();
  addBatteryProfile();
  subtractBatteryProfile();
  increaseDecreaseCurrentBatteryProfileButtons();
  sg.draw(dataPoints);
}

void settingsScreen(){}

void batteryProfile() {
  fill(0);
  textSize(20);
  text("Battery: "+currentBatteryProfile, 150, 100);
  text("Swap Profile", 150, 125);
}

void ESCAPEbutton() {
  escapeButton.draw();
  if (escapeButton.buttonClicked) {
    println("Button has been clicked");
    currentScreen = 0;
    escapeButton.buttonClicked = false;
  }
}


void currentVoltageButton() {
  currentVoltageButton.draw();
  if (currentVoltageButton.buttonClicked) {
    println("Button has been clicked");
    currentScreen = 1;
    currentVoltageButton.buttonClicked = false;
  }
}

void savedVoltageButton() {
  SV_button.draw();
  if (SV_button.buttonClicked) {
    println("Button has been clicked");
    currentScreen = 2;
    SV_button.buttonClicked = false;
  }
}

void addBatteryProfile() {
  increaseBatPro_button.draw();
  if (increaseBatPro_button.buttonClicked) {
    amountBatPro++;
    println(amountBatPro);
    increaseBatPro_button.buttonClicked = false;
  }
}

void subtractBatteryProfile() {
  decreaseBatPro_button.draw();
  if (decreaseBatPro_button.buttonClicked) {
    amountBatPro--;
    println(amountBatPro);
    decreaseBatPro_button.buttonClicked = false;
  }
}

void increaseDecreaseCurrentBatteryProfileButtons() {
  increaseCurrentBatteryProfileButton.draw();
  decreaseCurrentBatteryProfileButton.draw();
  if (increaseCurrentBatteryProfileButton.buttonClicked) {
    if (currentBatteryProfile < amountBatPro) {
      currentBatteryProfile++;
    }
    increaseCurrentBatteryProfileButton.buttonClicked = false;
  }
  if (decreaseCurrentBatteryProfileButton.buttonClicked) {
    if (currentBatteryProfile > 0) {
      currentBatteryProfile--;
    }
    decreaseCurrentBatteryProfileButton.buttonClicked = false;
  }
}

void settingButton() {
  settingsButton.draw();
  if (settingsButton.buttonClicked) {
    currentScreen = 3;
    settingsButton.buttonClicked = false;
  }
}
