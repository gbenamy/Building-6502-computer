# Chapter 4 - LCD Display

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

### The Commands

The commands are determined by the leading '1' followed by parameters: 

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/b2ebdb2c-01d1-433c-8262-3a54bd9329aa)

Parameters: 

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/7b27e676-16c3-4fb4-aa7a-53fdc2871518)


 ### Start Writing

 #### Key routines

```asm
;command - set display to 8bit mode, 2lines and 5x8 font

  lda #%00111000 ; set display to 8bit mode, 2lines and 5x8 font
  sta PORTB
```

```asm
;command - set display on, cursor on, blink off

  lda #%00001110 ; set display on, cursor on, blink off
  sta PORTB
```

```asm
;command - shift cursor right when writing, no display shift 

  lda #%00000110 ; shift cursor right when writing, no display shift 
  sta PORTB
```


```asm
  ;sending command routine
  ;keeping RS and RWB low while toggling E on/off

  lda #0
  sta PORTA ; clear E,RWB,RS 

  lda #E ; set E bit to send
  sta PORTA

  lda #0
  sta PORTA ; clear E,RWB,RS 
```

```asm
; writing a letter - H
  lda #"H"
  sta PORTB
```

```asm
 ;sending letter routine
  ;keeping RS high while toggling E on/off
  lda #RS
  sta PORTA ;  

  lda #(E | RS) ;
  sta PORTA

  lda #RS
  sta PORTA ; 
```

And we can now write all the letters for "Hello, World!" in a one big duplicate code!


After running the assembler

<img width="809" alt="image" src="https://github.com/gbenamy/Building-6502-computer/assets/24626396/b536d2de-10f8-4e72-8010-f15b18c9e4a5">

We can see the letters there






 


