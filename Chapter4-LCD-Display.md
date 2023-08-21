# Chapter 3 - LCD Display

---

Now let's add an LCD display

I'll use the Hitachi HD44780U LCD-II

![Image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/7d6e1c6d-3050-4fa6-baed-6b0feea535a8)

I'll start connecting the pins:

VSS - ground

VDD - 5V

V0 - via 1K resistor to set the contrast

D0/D7 - RAM's PB0/PB7

E - RAM's PA7

RW - RAM's PA6

RS - RAM's PA5

K - ground

A - 5V

### How the register select operates

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/94e1721d-adfe-4f60-951c-de2596d9705d)

So in case the RS is 0 and RWB is 0 (writing) - We are sending 'command' to the display.

In case the RS is 1 and the RWB is 0 (writing) - We are sending 'data' thp the display RAM.

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/79710a20-5818-4b98-a028-6102f08ce418)



