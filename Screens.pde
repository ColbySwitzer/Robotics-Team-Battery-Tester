
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
  currentGraphDisplay();
}

void savedDataScreen() {
  background(255);
  batteryProfile();
  ESCAPEbutton();
  addBatteryProfile();
  subtractBatteryProfile();
  increaseDecreaseCurrentBatteryProfileButtons();
}

void batteryProfile() {
  fill(0);
  textSize(20);
  text("Battery: "+currentBatteryProfile, 150, 100);
  text("Swap Profile", 150, 125);
}

void ESCAPEbutton() {
  ESC_button.draw();
  if (ESC_button.buttonClicked) {
    println("Button has been clicked");
    currentScreen = 0;
    ESC_button.buttonClicked = false;
  }
}


void currentVoltageButton() {
  CV_button.draw();
  if (CV_button.buttonClicked) {
    println("Button has been clicked");
    currentScreen = 1;
    CV_button.buttonClicked = false;
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
