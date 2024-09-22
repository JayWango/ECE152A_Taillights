**Lab 4: Thunderbird Taillights Simulation**

**PART A**
- Started with the design of a finite state machine (FSM) by drawing a Moore state diagram with 12 total states to help visualize the combination of inputs that would cause the taillights to switch states 

**PART B**
- Implemented our FSM in SystemVerilog, and then compiled/tested the program in Modelsim to verify that our inputs would create the expected output signals 

**PART C**
- Synthesizd Verilog program, assigned general purpose I/O pins for circuit, and downloaded design onto Altera FPGA using Quartus
- Constructed a working circuit composed of 6 LEDs, a 10-input DIP switch, and a FPGA to simulate a car's taillight behavior when the turn, brake, hazard, and running lights are on
