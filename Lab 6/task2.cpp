const int led1Pin = 8;
const int led2Pin = 9;

const unsigned long intervalLED1 = 500;
const unsigned long intervalLED2 = 1000;

unsigned long previousLED1 = 0;
unsigned long previousLED2 = 0;

int LED1State = LOW;
int LED2State = LOW;

void setup() {
  pinMode(led1Pin, OUTPUT);
  pinMode(led2Pin, OUTPUT);
}

void loop() {
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillisLED1 >= intervalLED1) {
    previousMillisLED1 = currentMillis;
    led1State = (led1State == LOW) ? HIGH : LOW;
    digitalWrite(led1Pin, led1State);
  }

  if (currentMillis - previousMillisLED2 >= intervalLED2) {
    previousMillisLED2 = currentMillis;
    led2State = (led2State == LOW) ? HIGH : LOW;
    digitalWrite(led2Pin, led2State);
  }
}