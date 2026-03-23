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

<<<<<<< HEAD

=======
Power of Friendship (POF) force:

equation:
Fpof = k * (p1p2/r^2) - C
>>>>>>> 740eee853013b462b6c69ea23e6784a1c2711c0b

### Custom Force Breakdown
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - the posiiton of the orb, which is what is used to calculate the radius
  - the mass of the orb

- Does this force require any new constants, if so what are they and what values will you try initially?
  - we need a conflict level between two orbs

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - yes, it requires orbs to have beef with each other
    how this works is that every orb creates a sorted ranking list of their favorite other orbs in the system, whcih is stored as an array within themselves (best->worst orb). Then, when calculating the force between orb i and j, we will find the index of orb j in orb i's ranking, and convert that index into a conflict value C.

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  each orb experiences a force due to every other orb in the system. the behavior of each orb is determined by its neighbors. 

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
 distance between two forces: distance formula
ranking lookup, determine the position of one Orb in another Orb’s ranked list
conflict calculation
final force computation
--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

<<<<<<< HEAD
An object in orbit has velocity in a linear direction, but its acceleration vector is perpendicular to its velocity vector, and towards the COM (whatever the smaller object is orbiting around) <-- centripedal motion!
To simulate this:
- one fixed orb, smaller, less mass orb w an initial velocity.
- use the gravitational attraction equation to apply an acceleration on the smaller orb towards the fixed orb.
=======
by using centripedal acceleration (giving every orb velocity but then an acceleration vector perpendicular to it) and putting a fixed, very massive orb in the center.

>>>>>>> 740eee853013b462b6c69ea23e6784a1c2711c0b
--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

<<<<<<< HEAD
Similar to lab, using f = kx
- simulate longitudual waves also?
=======
similar to lab, multiple orbs connected by springs in a chain or network structure. while running, strings will apply force based on how much they are stretched or compressed relative to their length. The system should oscillate.
>>>>>>> 740eee853013b462b6c69ea23e6784a1c2711c0b

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

<<<<<<< HEAD
wind tunnel simulation!
orb/teardrop/rectangle/fighter jet looking thing <-- choose which one you want
you can toggle whether or not drag is activated, and you can see its speed change!
=======
The drag simulation will contain elements from both the lab and w58_orb. The idea discussed during class was to make a "wind tunnel" in order to have visual indications that  can clearly show drag force being implemented. Another option is to have a similar setup to w58 with having the lowr half be the fluid that once teh orbs reach the drag force is implemented. Of course with DragForce, gravity must be present for anything to "actually" happen. While running the orbs, must slow down as the force "pushes" in the direction opposite the velocity of the orbs.
>>>>>>> 740eee853013b462b6c69ea23e6784a1c2711c0b

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

<<<<<<< HEAD
the POWER OF FRIENDSHIP!

- each orb has a certain material
- orbs of the same material have more of an attraction to each other. 

=======
The custom force simulation would include all the orbs lined up in a row. There will be toggles to turn both moving ON and custom force ON. As described above, while running, the orbs will visually be experincing a force from its neighbors as there is a conflic level between two orbs meaning we have to account for all possible pairs of orbs.   
>>>>>>> 740eee853013b462b6c69ea23e6784a1c2711c0b

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

<<<<<<< HEAD
=======
A combination would be gravity, spring force, and our custom force. Set up would either be the same as the lab where there is a fixed object present where the gravity is accounted from or have the orbs be randomly faced with toggles to turn ON each force. The behavor of this simulation isnt clear yet as our custom force hasnt been planned out clearly yet. Though, a possibility is that it might behave in a similar manner of when you Toggle ON gravity and spring just that the orbs will interact with each other. 
>>>>>>> 740eee853013b462b6c69ea23e6784a1c2711c0b

