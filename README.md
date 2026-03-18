[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-jWdCFXs)
## Project 00
### NeXTCS
### Period: 10
## Thinker0: Nabila Rahman
## Thinker1: Marcus Markova
## Ducky: Caroline
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: POWER OF FRIENDSHIP

### Custom Force Formula
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)



### Custom Force Breakdown
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - YOUR ANSWER HERE

- Does this force require any new constants, if so what are they and what values will you try initially?
  - YOUR ANSWER HERE

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - YOUR ANSWER HERE

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - YOUR ANSWER HERE

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - YOUR ANSWER HERE

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

An object in orbit has velocity in a linear direction, but its acceleration vector is perpendicular to its velocity vector, and towards the COM (whatever the smaller object is orbiting around) <-- centripedal motion!
To simulate this:
- one fixed orb, smaller, less mass orb w an initial velocity.
- use the gravitational attraction equation to apply an acceleration on the smaller orb towards the fixed orb.
--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

Similar to lab, using f = kx
- simulate longitudual waves also?

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

wind tunnel simulation!
orb/teardrop/rectangle/fighter jet looking thing <-- choose which one you want
you can toggle whether or not drag is activated, and you can see its speed change!

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

the POWER OF FRIENDSHIP!

- each orb has a certain material
- orbs of the same material have more of an attraction to each other. 


--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.


