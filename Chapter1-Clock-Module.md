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

![Internal Diagram](https://user-images.githubusercontent.com/24626396/182017112-2332940f-da9b-48ac-b9a1-3e80cf21e467.png)

Another more accurate schematic
![555](https://user-images.githubusercontent.com/24626396/208178341-11153e01-693e-471f-a22e-2dc64b39de3d.jpeg)


## Inside 555

I'll simulate the 555 component circuitary to show it's inner behaviour:
### schematics:
![Screenshot 2022-12-09 at 12 11 50](https://user-images.githubusercontent.com/24626396/206679648-91a858e8-b57b-4aad-b958-c37ae37e4af2.png)


![Screen Recording 2022-12-09 at 11 44 27](https://user-images.githubusercontent.com/24626396/206677685-50c705a1-e20f-4502-a175-ee27f192479a.gif)

We can see the current flow, and how it generates the square wave.

## building the circuit

### Phase 1 - Two resistors: 
I'll simulate the beardboard design with 555 chip verify

![Screenshot 2022-12-21 at 21 18 25](https://user-images.githubusercontent.com/24626396/208986560-f517ef83-c629-4223-9add-4aebe3c5f42c.png)

![IMG_7347](https://user-images.githubusercontent.com/24626396/208985293-c354f52c-d60b-4cf3-a2e9-6a54753547a1.jpg)
![circuit 2 resistors](https://user-images.githubusercontent.com/24626396/208985612-d077d0cb-8291-4eb2-ba78-23184bee9093.gif)

It works!
let's calculate the period time T:

Charging circuit:
![Screenshot 2022-12-21 at 23 48 17](https://user-images.githubusercontent.com/24626396/209008563-c71a8128-1eb6-49bf-9d85-fe6cff4a0978.png)

Discharging circuit:
![Screenshot 2022-12-21 at 23 49 18](https://user-images.githubusercontent.com/24626396/209008823-5b20926e-481c-43d9-b37a-a48ad8bef9f1.png)

In my circuit I have used:
$$Ra=10^3Ω$$

$$Rb=10^6Ω$$

$$C1=1 \mu F$$
