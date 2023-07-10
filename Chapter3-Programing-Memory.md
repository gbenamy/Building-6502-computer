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










