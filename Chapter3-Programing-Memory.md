### Chapter3-Programing-Memory.md

So in order to write more interesting code than the hardwired nop ('ea' - no operation),

I'll use a ROM chip to hold the code and data to execute from.

We'll be using the AT28C256 EEPROM, 32KB.

![Image Medium](https://github.com/gbenamy/Building-6502-computer/assets/24626396/f9cc3dfd-6909-47d8-b85c-67c7cee75eba)


### Schematics

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/ffe5fb85-2792-4410-8f10-d3f56edfc2bb)

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/b069ae6e-069c-40b9-a29d-bfc323ac244f)

Our 6502 chip has 16bit to represent the address, meaning 64K addresses.

Our **EEPROM** has 15bit to represent the address, meaning 32K adresses.

So we need to choose to which 'half' of the 6502 chip address space we'll map the rom.

Since the chip, after the reset sequence as we saw in the previous chapter, is loading the data in FFFC and FFFD as the address of the begining of our code,

We'll choose the higher half 0x0800-0xFFFF.

The chip **A15**, chip address MSB, will be connected vi inverter (using NAND gate) to the ROM **!CE**, and will enable the ROM (as it is always '1' in the higher address half)

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/658c2c9a-9dff-45f9-af6b-fdfc0444d699)


* **!WE** - Will be tied to high, as we only want to read from the ROM
* **!OE** - Will be tied to low, as we want the outout to always be enabled as long as the chip is enabled (**!CE**)
* **I/O0-I/O7** - Will be connected to the microcontroller **D0-D7**
* **A0-14** - Will be connected to the mictrocontroller **A0-A14**

### ROM and connections test

I'll fill the ROM with Oxea ,the 'no operation' opcode, and we'll see if we get the same behaviour as when I hardwired 'ea':



Using python

```python
rom = bytearray([0xea]*32768)
with open ("rom.bin", "wb") as file:
    file.write(rom)
```

Let's validate

<img width="458" alt="image" src="https://github.com/gbenamy/Building-6502-computer/assets/24626396/6e8a75c5-9e1c-459d-a6ed-49494ab955ce">

Let's connect and see if it is the same behaviour:

We can see some flunctuations, I'll speed up the clock so it will be more clear

https://github.com/gbenamy/Building-6502-computer/assets/24626396/4adbdacb-aafd-4e38-80c8-19e9e38e0653

Some data lines are fluctuating occasionally, seems like D1,D3,D5.




### The bad news

After two evenings invastigating the issue, and reconnecting all address/data conectors, re-flushing the rom, changing it to a different starting address.
the VCC leg of the ROM has broken..
Soldering it would not help.

A quick note, the chip legs are relatively strong, but once dent (due to improper pulling out the chip from the breadboard) and straighten it,
it becomes very fragile.

![Image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/46fb16a8-72cc-4689-b88f-f8bd2464856f)



I've ordered a new chip (will arrive in 2-3 weeks)

For now I'll improvise and use a mush smaller EEPROM I got:

### Improvisation

AT28C16

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/3b86e5fe-db69-4ac4-8a9b-c2d89b98b52a)

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/a519927b-9d94-49b8-bde5-c39215881c03)


it's a 2K byte EEPROM.

I've created a little 'handle' so it won't happen again 😁

![IMG_9001 Medium](https://github.com/gbenamy/Building-6502-computer/assets/24626396/6e59ed75-bd90-41d5-8a75-6ccd2bce9519)


Let's flush 'ea'

```python
rom = bytearray([0xea]*2048)
with open ("rom.bin", "wb") as file:
    file.write(rom)
```

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/18d44fca-d0df-4ae3-b9ff-075a17a7c70b)

Well, it seems that the programmer TL866+ has an issue writing to the AT28C16
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/d6f48e1e-890c-4aa6-a10e-d1a81b2c244b)

Searching online suggested to lower the writing speed. 

https://www.reddit.com/r/beneater/comments/dck8ye/atmel_28c16_programming_issues_with_xgecu_tl866/

This guy have found a solution to make it write slower using a different model in the command

and it worked!

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/dc0896ac-73e8-4932-9768-471015e00e5b)


As we can see, the new EEPROM has 11 address pins, meaning 2K byte.

We need to decide were to 'map' these 2K.

As before, because the the 6502 microchip loads FFFC and FFFD as the start of the program,

I'll map the 2k ROM to the last 1/32 of the addresses supported by the 6502 microchip:

```
1111 1000 0000 0000   -  F800
```
till
```
1111 1111 1111 1111   -  FFFF
```

I'll add this logic for A11-A15 on the 6502 microchip connected to the EEPROM CEB
![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/0f517054-2e1d-4bca-ac13-584a43645daf)




AND gates: 

DM74LS08

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/fc844fe8-fdaf-46c8-aba6-7163d8a2e97f)

I'll flush the EEPROM with 'ea', except for 0xFFFC 0xFFFD as i'll use the first address that exist in the new EEPROM address mapping: 0xF800
the 11 address bytes of 0xFFFC and 0xFFFD will be 0x7FC 0x7FD, as we flush it on 2K byte rom with 11 address pins.

```python
rom = bytearray([0xea]*2048)

rom[0x7fc] = 0x00
rom[0x7fd] = 0xf8

with open ("rom.bin", "wb") as file:
    file.write(rom)
```

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/cd63b2ed-721d-4070-88af-41d62435fb9c)



And it's working!

We can see the reboot sequence, loading the address 0xF800 and starting to execute the 'ea' from that point

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/6c69503a-d8c2-44da-bc40-3910775d46f2)


![IMG_9007](https://github.com/gbenamy/Building-6502-computer/assets/24626396/0e5c8571-cc7d-4123-a742-2739153c771d)




