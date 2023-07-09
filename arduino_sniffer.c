const char ADDR[] = { 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52 };
const char DATA[] = { 39, 41, 43, 45, 47, 49, 51, 53 };
#define CLOCK 2
#define R_W 3



void onClock() {
  // put your main code here, to run repeatedly:
  char output[15];
  unsigned int address = 0, data = 0;
  for (int n = 0; n < 16; n++) {
    int bit = digitalRead(ADDR[n]) ? 1 : 0;
    Serial.print(bit);
    address = (address << 1) + bit;
  }

  Serial.print("   ");

  for (int n = 0; n < 8; n++) {
    int bit = digitalRead(DATA[n]) ? 1 : 0;
    Serial.print(bit);
    data = (data << 1) + bit;
  }
  sprintf(output,"      %04x   %02x  %c",address,data,digitalRead(R_W) ? 'r':'W');
  Serial.println(output);
}

void setup() {
  // put your setup code here, to run once:

  for (int n = 0; n < 16; n++) {
    pinMode(ADDR[n], INPUT);
  }

  for (int n = 0; n < 8; n++) {
    pinMode(DATA[n], INPUT);
  } 
  pinMode(CLOCK, INPUT);
  pinMode(R_W, INPUT);
  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);
  Serial.begin(57600);
}

void loop() {
}
