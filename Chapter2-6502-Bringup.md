
# Chapter 1 - 6502 Bring-up

![IMG_8886](https://github.com/gbenamy/Building-6502-computer/assets/24626396/589755c5-75be-446e-aa2f-de8a301faca4)

## Starting poking the chip!
#### The chip pins:
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/6497d1fc-58fc-44c8-a966-eb8f9848188b)

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/a36bbae1-8163-4fed-896a-cdeb2fc414a0)

I'll connect the power supply to VDD and VSS, the clock to PHI2.
All input pins will be tied to 5V(), and we'll take a look on what is happening:
##### Input Pins:
 
RDY
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/f6fb9cde-d64f-44d2-85d4-bd5f2fc0e830)
IRQB
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/6c17d7d3-3823-4cbf-a0f0-b432dc1863d0)
NMIB
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/602c6d8f-e065-40cd-a440-1f32fca027f1)
BE
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/bcee58d2-6852-4435-b6f1-963d38a92436)
SOB
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/a8832d17-934d-4d9c-aaa8-ff354122889a)
And the Reset, it needs to be tied high in order for the microprocessor to run, we'll add a button for reseting, shorting to ground.

![IMG_8887](https://github.com/gbenamy/Building-6502-computer/assets/24626396/c5e39894-df28-4ba6-8855-b7f34b325b4c)


### Insepecting

I'll connect the Arduino and see what can we learn from A0-15

![Image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/61d83f2d-de05-4362-983c-69f4ed5b2304)

The code:
```c
const char ADDR[] = {22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52};

void setup() {
  // put your setup code here, to run once:

  for (int n = 0; n<16; n++){
    pinMode(ADDR[n], INPUT);
  }
  Serial.begin(57600);

}

void loop() {
  // put your main code here, to run repeatedly:
  for (int n = 0; n<16; n++){
    int bit = digitalRead(ADDR[n]) ? 1:0;
    Serial.print(bit);
  }
  Serial.println();

}
```



https://github.com/gbenamy/Building-6502-computer/assets/24626396/08d068fa-3888-45a8-964e-9bb2cb96f774



Let's add D0-D7 and refine the sampaling printing only on clock connected to Arduino's pin2 and acts as interupt

The code:
```c
const char ADDR[] = { 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52 };
const char DATA[] = { 39, 41, 43, 45, 47, 49, 51, 53 };
#define CLOCK 2

void onClock() {
  // put your main code here, to run repeatedly:
  for (int n = 0; n < 16; n++) {
    int bit = digitalRead(ADDR[n]) ? 1 : 0;
    Serial.print(bit);
  }

  Serial.print("    ");

  for (int n = 0; n < 8; n++) {
    int bit = digitalRead(DATA[n]) ? 1 : 0;
    Serial.print(bit);
  }
  Serial.println();
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
  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);
  Serial.begin(57600);
}

void loop() {
}
```

https://github.com/gbenamy/Building-6502-computer/assets/24626396/f27f04a0-59f8-41d6-ba6f-bfeaa981da2f

for conivnience let's display the address in Hex as well

```c
void onClock() {
  // put your main code here, to run repeatedly:
  char output[15];
  unsigned int address = 0, data = 0;
  for (int n = 0; n < 16; n++) {
    int bit = digitalRead(ADDR[n]) ? 1 : 0;
    //Serial.print(bit);
    address = (address << 1) + bit;
  }

  //Serial.print("    ");

  for (int n = 0; n < 8; n++) {
    int bit = digitalRead(DATA[n]) ? 1 : 0;
    //Serial.print(bit);
    data = (data << 1) + bit;
  }
  sprintf(output,"  %04x  %02x",address,data);
  Serial.println(output);
}
```

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/d5d838fb-9e5c-492c-96b1-bf4af5b54ee5)

Let's also monitor the RWB, to see if the data is being read or written

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/180d11e5-d7b6-472f-8ecc-4de8856499be)

Let's connect it to pin3:

```c
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


```
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/8f4f572d-4d7e-487a-8a54-7f52043cc71a)




