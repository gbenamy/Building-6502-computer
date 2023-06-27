# Chapter 1 - The Clock Module
## Building a stable, monostable, and bistable computer clock using 555 timer


Following Ben Eater's [clock module](https://www.youtube.com/watch?v=kRlSFm519Bo) youtube and [kit](https://eater.net/6502)

The computer’s clock is used to synchronize all operations. 
This clock is based on the popular 555 timer IC.

The clock is adjustable-speed (from less than 1Hz to a few hundred Hz). The clock can also be put into a manual mode where you push a button to advance each clock cycle. This will be a really useful to take things slowly and realy follow the opcodes execuitions.


## The Final Circuit:
---

![Image 4](https://user-images.githubusercontent.com/24626396/181102423-eb7ff0f3-c349-4de2-b6a5-b051dea38f89.jpeg)


## Schematic

![Schematic](https://user-images.githubusercontent.com/24626396/182015828-2186748a-5bb4-46c3-b7c6-221fbd3168dc.png)

---

Let's start by getting a deeper understanding on the heart of the circuit.

## 555 module
from the data sheet:
![555](https://user-images.githubusercontent.com/24626396/182016977-d86b5ea5-1a74-4641-b700-e2ee85a75d9e.png)

## Inside 555

![Internal Diagram](https://user-images.githubusercontent.com/24626396/182017112-2332940f-da9b-48ac-b9a1-3e80cf21e467.png)

Another more accurate schematic
![555](https://user-images.githubusercontent.com/24626396/208178341-11153e01-693e-471f-a22e-2dc64b39de3d.jpeg)




# astable 555 circuit

It is called astable as it constatnly flips between the states.

I'll simulate the 555 component circuitary to show it's inner behaviour:
### schematics:
![Screenshot 2022-12-09 at 12 11 50](https://user-images.githubusercontent.com/24626396/206679648-91a858e8-b57b-4aad-b958-c37ae37e4af2.png)


![Screen Recording 2022-12-09 at 11 44 27](https://user-images.githubusercontent.com/24626396/206677685-50c705a1-e20f-4502-a175-ee27f192479a.gif)

We can see the current flow, and how it generates the square wave.

## 555 astable operation - building the circuit

### Phase 1 - Two resistors: 
I'll simulate the beardboard design with 555 chip verify

![Screenshot 2022-12-21 at 21 18 25](https://user-images.githubusercontent.com/24626396/208986560-f517ef83-c629-4223-9add-4aebe3c5f42c.png)

![IMG_7347](https://user-images.githubusercontent.com/24626396/208985293-c354f52c-d60b-4cf3-a2e9-6a54753547a1.jpg)
![circuit 2 resistors](https://user-images.githubusercontent.com/24626396/208985612-d077d0cb-8291-4eb2-ba78-23184bee9093.gif)

It works!

I've added $0.01 \mu F$ capacitor connected to the 555 5th leg and a $0.1 \mu F$ capacitor on the power sorce in order to 'clean' the signal, as recomended in the datasheet. 

let's calculate the period time T:

Charging circuit:
![Screenshot 2022-12-21 at 23 48 17](https://user-images.githubusercontent.com/24626396/209008563-c71a8128-1eb6-49bf-9d85-fe6cff4a0978.png)

Discharging circuit:
![Screenshot 2022-12-21 at 23 49 18](https://user-images.githubusercontent.com/24626396/209008823-5b20926e-481c-43d9-b37a-a48ad8bef9f1.png)

In my circuit I have used:
$$Ra=10^3Ω$$

$$Rb=10^6Ω$$

$$C1=1 \mu F$$

##TODO: add computation

## Phase 2 - Switching to potentiometer
In order to be able to adjust the speed of the clock as needed, I'll repleace the resistor with an adjustable one, a potentiometer.

![potentiometer](https://user-images.githubusercontent.com/24626396/209213097-ff0bac2d-1555-4522-aad8-221cbb8383a9.gif)





# Monostable 555 circuit
We may need to control the clock manually, in order to debug, or slow down to better follow the code. 
Since a single push on a simple button may triger several 'clocks'

![Screenshot 2023-01-10 at 21 04 49](https://user-images.githubusercontent.com/24626396/212499503-ed26324f-6583-4286-93bc-a52d10f89e3f.png)


I will use the 555 monostable configuration to produce a clean single clock pulse. 

## The debouncing circuit 
![Screenshot 2023-01-10 at 21 17 19](https://user-images.githubusercontent.com/24626396/212499473-f5a5ddfb-8636-4043-9007-4186ba78b610.png)

Let's simulate:
![Screen Recording 2023-01-14 at 23 54 232](https://user-images.githubusercontent.com/24626396/212499493-cc04f5cf-cf99-4338-8da0-a125ce3c7b6c.gif)

And the result:

![IMG_8874](https://github.com/gbenamy/Building-6502-computer/assets/24626396/d4e68780-eab4-4a26-b87c-6b6967c78596)



## Phase 3 - Switching between the modes
In order to be able to conveniently switch between the manual clock and oscillating clock, I'll use a switch.

I'll use another 555 timer to debounce the switch to avoid the bouncing issue as in phase 2.
We can use the SR latch as the debouncer:

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/eaebf4dd-bd93-4bbe-9e2c-b485a3a38b3c)

On top of the debounced switch, we'll use a little bit of logic to determine the output:

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/45653af8-8b7f-4131-92e7-09d68f6356ea)

Using these components:

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/681f70c0-1dfd-4c36-9dca-81ccee74139a)

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/ff9e9382-120c-4a7d-a47d-f9153ecb1e11)

![image](https://github.com/gbenamy/Building-6502-computer/assets/24626396/77f69627-6ffb-4427-8b8f-3d4dd6e387f8)







