#include <LiquidCrystal.h>

//LCD Screen
const int rs = 12, en = 11, d4 = 5, d5 = 4, d6 = 3, d7 = 2;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

//Button Pins
const int increaseButtonPin = 9;
const int decreaseButtonPin = 8;
const int enterButtonPin = 7;
bool buttonsReady = true;

//Timer System Values
int minutes = 0;
int seconds = 0;
bool setMinutes = true;
bool timerSet = false;
unsigned long previousMillis = 0;
const long interval = 1000;

//Voltage Sensor Values
#define ANALOG_IN_PIN A5
const int potPin = A0;
int potValue = 0;
float adc_voltage = 0.0;
float in_voltage = 0.0;
float R1 = 30000.0;
float R2 = 7500.0;
float ref_voltage = 5.0;
int adc_value = 0;

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
  lcd.print("Set minutes:");
  pinMode(increaseButtonPin, INPUT);
  pinMode(decreaseButtonPin, INPUT);
  pinMode(enterButtonPin, INPUT);
}

void loop() {

  if (digitalRead(increaseButtonPin) == HIGH && buttonsReady) {
    if (setMinutes) {
      increaseMinutes();
    } else {
      increaseSeconds();
    }
    buttonsReady = false;
  } else {
    buttonsReady = true;
  }

  if (digitalread(drecreaseButtonPin) == HIGH && buttonsReady) {
    if (setMinutes) {
      decreaseMinutes();
    } else {
      decreaseSeconds();
    }
    buttonsReady = false;
  } else {
    buttonsReady = true;
  }

  if (digitalRead(enterButtonPin) == HIGH && buttonsReady) {
    if (setMinutes) {
      setMinutes = false;
      lcd.clear();
      lcd.print("Set seconds:");
    } else {
      timerSet = true;
      lcd.clear();
      lcd.print("Timer set!");
      delay(1000);
    }
    buttonsReady = false;
  } else {
    buttonsReady = true;
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
          lcd.print("Time's up!");
          while (true)
            ;
        }
      }
      updateDisplay();
      potValueCheck();
    }
  }
}

void updateDisplay() {

  lcd.setCursor(0, 1);

  if (minutes < 10) {
    lcd.print("0");
  }
  lcd.print(minutes);
  lcd.print(":");
  if (remainingSeconds < 10) {
    lcd.print("0");
  }
  lcd.print(remainingSeconds);
}

void potValueCheck() {
  potValue = analogRead(potPin);  // Read the potentiometer value (0 to 1023)
  Serial.println(potValue);
}

void getVoltage() {
  adc_value = analogRead(ANALOG_IN_PIN);

  adc_voltage = (adc_value * ref_voltage) / 1024.0;
  in_voltage = adc_voltage * (R1 + R2) / R2;

  Serial.println(in_voltage, 2);
}
