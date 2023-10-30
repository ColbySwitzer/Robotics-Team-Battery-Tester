#include <LiquidCrystal.h>


//LCD Pins
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
//Timer Button Pins
const int increaseButtonPin = 9;  // Pin for increase time button
const int decreaseButtonPin = 8;  // Pin for decrease time button
const int enterButtonPin = 7;     // Pin for enter time selected button
bool everyButtonReady = true;
bool enterButtonReady = true;

int hours = 0;
int minutes = 0;
int seconds = 0;
bool setHours = 0;
bool setMinutes = true;
bool setSeconds = true;
bool timerSet = false;

unsigned long previousMillis = 0;
const long interval = 1000;

const int potPin = A0;  // Pin connected to the potentiometer
int potValue = 0;

#define ANALOG_IN_PIN A5

//Voltage Sensor
float adc_voltage = 0.0;
float in_voltage = 0.0;
float R1 = 30000.0;
float R2 = 7500.0;
float ref_voltage = 5.0;
int adc_value = 0;

void setup() {
  Serial.begin(9600);  // Start serial communication at 9600 bps
  lcd.begin(16, 2);
  lcd.print("Set Minutes: ");
  //pinMode(enablePin, INPUT);
  pinMode(increaseButtonPin, INPUT);
  pinMode(decreaseButtonPin, INPUT);
  pinMode(enterButtonPin, INPUT);
}

void loop() {
  //Check if the increase button is pressed
  if (digitalRead(increaseButtonPin) == HIGH && everyButtonReady) {
    everyButtonReady = false;
    if (setMinutes) {
      increaseMinutes();
    } else if (setSeconds) {
      increaseSeconds();
    }
  }


  //Check if the decreasee button is pressed
  if (digitalRead(decreaseButtonPin) == HIGH && everyButtonReady) {
    everyButtonReady = false;
    if (setMinutes) {
      decreaseMinutes();
    } else if (setSeconds) {
      decreaseSeconds();
    }
  }

  if (digitalRead(enterButtonPin) == HIGH && everyButtonReady) {
    everyButtonReady = false;
    if (setMinutes) {
      setMinutes = false;
      lcd.clear();
      lcd.print("Set seconds: ");
    } else if (setMinutes == false && setSeconds) {
      setSeconds = false;
    } else {
      timerSet = true;
      lcd.clear();
      lcd.print("Timer set!");
      delay(1000);
    }
  }

  if (digitalRead(increaseButtonPin) == LOW && digitalRead(decreaseButtonPin) == LOW && digitalRead(enterButtonPin) == LOW) {
    everyButtonReady = true;
  }

  if (timerSet) {
    unsigned long currentMillis = millis();

    if (currentMillis - previousMillis >= interval) {
      previousMillis = currentMillis;

      if (seconds > 0) {
        seconds--;
      } else {
        if (minutes > 0) {
          minutes--;
          seconds = 59;
        } else {
          lcd.clear();
          lcd.print("Deli Ham");
          while (true);
        }
      }
      updateDisplay();
      potValueCheck();
    }
  }
}

void increaseMinutes() {
  if (minutes < 99) {
    minutes++;
  }
  updateDisplay();
}

void decreaseMinutes() {
  if (minutes > 0) {
    minutes--;
  }
  updateDisplay();
}

void increaseSeconds() {
  if (seconds < 59) {
    seconds++;
  }
  updateDisplay();
}

void decreaseSeconds() {
  if (seconds > 0) {
    seconds--;
  }
  updateDisplay();
}

void updateDisplay() {
  lcd.setCursor(0, 1);

  if (minutes < 10) {
    lcd.print("0");
  }
  lcd.print(minutes);
  lcd.print(":");
  if (seconds < 10) {
    lcd.print("0");
  }
  lcd.print(seconds);
}


void potValueCheck() {
  potValue = analogRead(potPin);
  Serial.println(potValue);
}

void getVoltage() {
  adc_value = analogRead(ANALOG_IN_PIN);

  adc_voltage = (adc_value * ref_voltage) / 1024.0;
  in_voltage = adc_voltage * (R1 + R2) / R2;

  Serial.println(in_voltage, 2);
}
