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
