# Digital Locker Security System

A Verilog-based digital locker security system that verifies a user-entered 4-bit code against a stored secret code. The design is implemented using modular digital circuits such as D flip-flops, multiplexers, comparators, counters, full adders, and logic gates.

The system also includes an attempt counter and a temporary lockout mechanism to prevent unlimited incorrect attempts.

---

## Project Overview

The objective of this project is to design a secure digital locker using fundamental digital logic building blocks and verify its functionality using a self-checking Verilog testbench.

The locker stores a 4-bit secret code and receives the user's code serially, one bit at a time. After four bits are received, the entered code is compared with the stored secret code.

If the codes match, the locker generates an `open` signal.

If the entered code is incorrect, the failed-attempt counter is incremented. After five incorrect attempts, the user input is temporarily blocked and a timer starts counting before the system allows new attempts.

---

## Key Features

- 4-bit secret code storage
- Serial user-code input
- 4-bit code comparison
- Automatic code verification
- `open` signal generation for a correct code
- Failed-attempt counter
- Maximum attempt limit of 5
- Temporary input blocking after repeated failures
- 5-bit timer for lockout duration
- Automatic reset of the attempt counter after the lockout period
- Asynchronous reset
- Modular structural Verilog implementation
- Self-checking verification using a golden reference model

---

## Design Architecture

The design is constructed using multiple reusable digital logic modules.

### Major Building Blocks

- 1-bit D Flip-Flop
- 3-bit D Flip-Flop
- 4-bit D Flip-Flop
- 5-bit D Flip-Flop
- 4-bit Serial Shift Register
- 3-bit Counter
- 1-bit, 3-bit, 4-bit and 5-bit Comparators
- 3-bit Incrementer
- 5-bit Incrementer
- 1-bit, 3-bit and 5-bit Multiplexers
- AND gates
- OR gates
- Full Adder
- Top-level Digital Locker

---

## Secret Code Storage

The secret code is stored using a 4-bit register.

The input code is loaded into the internal 4-bit register and remains available for comparison with the user's entered code.

The stored code is represented by:

```text
Secret Code → 4-bit Register
```

## Verification

A self-checking testbench was developed to validate the Secure Digital Locker Circuit.

- Created a behavioral golden reference model
- Performed cycle-by-cycle comparison between the DUT and reference model
- Verified correct and incorrect user-code entries
- Tested attempt counter functionality
- Tested the 5-attempt lockout condition
- Verified timer-based input blocking and re-enabling
- Added automatic mismatch detection using `error_count`

Simulation completed with **zero mismatches**.

---

## EDA Playground Link

The complete Verilog design and self-checking testbench are available on EDA Playground for simulation and verification.

- EDA Playground Link: https://www.edaplayground.com/x/azf8

The playground includes the Secure Digital Locker Circuit, its supporting RTL modules, and the self-checking testbench used to verify code matching, failed-attempt counting, lockout, and timer functionality.

---

## Key Takeaways

- Gained hands-on experience with structural RTL design
- Improved understanding of reusable digital hardware blocks
- Learned to design code-storage and serial-shift-register circuits
- Strengthened understanding of comparators, counters, incrementers, and multiplexers
- Learned how to implement an attempt-based security mechanism
- Developed a behavioral golden reference model for verification
- Built a reliable self-checking verification environment
- Gained practical experience with automatic mismatch detection
- Improved understanding of timer-based control and input blocking
