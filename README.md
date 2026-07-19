# Synchronous-FIFO-RTL-and-SystemVerilog-Verification

## Overview

This project implements a parameterized **Synchronous FIFO (First-In First-Out)** in Verilog and verifies its functionality using a self-checking **SystemVerilog testbench**. The verification environment is developed using an object-oriented methodology with components such as Generator, Driver, Monitor, Scoreboard, and Environment.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Specifications](#specifications)
- [RTL Design](#rtl-design)
- [Verification Environment](#verification-environment)
- [Simulation Results](#simulation-results)
- [How to Run](#how-to-run)
- [Tools Used](#tools-used)
- [Future Improvements](#future-improvements)

  ## Features

- Parameterized synchronous FIFO design
- Configurable FIFO depth and data width
- Full and Empty flag generation
- Circular buffer implementation
- Object-oriented SystemVerilog verification environment
- Randomized stimulus generation
- Self-checking scoreboard
- Automatic data integrity verification
- Modular and reusable testbench architecture

  ## Architecture

The synchronous FIFO consists of a memory array, read/write pointer logic, occupancy tracking, and status flag generation. All operations are synchronized to a single clock.


### Architecture Components

| Component | Description |
|-----------|-------------|
| FIFO Memory | Stores data in a parameterized memory array. |
| Write Pointer | Points to the next location where incoming data will be written. |
| Read Pointer | Points to the next location from which data will be read. |
| Write Logic | Writes data into the FIFO when `wr_en` is asserted and the FIFO is not full. |
| Read Logic | Reads data from the FIFO when `rd_en` is asserted and the FIFO is not empty. |
| Full Flag Logic | Indicates that the FIFO has reached its maximum storage capacity. |
| Empty Flag Logic | Indicates that no valid data is available for reading. |

## Specifications

| Parameter | Description | Default Value |
|-----------|-------------|---------------|
| `DATA_WIDTH` | Width of each FIFO data word | 32 |
| `FIFO_DEPTH` | Number of FIFO storage locations | 8 |

### General Specifications

| Specification | Value |
|--------------|-------|
| FIFO Type | Synchronous FIFO |
| Clock | Single Clock |
| Reset | Active-Low Synchronous Reset |
| Memory Organization | Circular Buffer |
| Verification | Object-Oriented SystemVerilog Testbench |
| Simulator | Xilinx Vivado XSim |

## RTL Design

The synchronous FIFO is implemented as a parameterized circular buffer using a single clock domain. It supports concurrent read and write operations while maintaining data integrity through pointer management and status flag generation.

### FIFO Memory

- Implemented as a parameterized memory array.
- Stores data in a First-In First-Out (FIFO) order.
- Supports configurable data width and FIFO depth.

### Write Logic

- Data is written into the FIFO when:
  - `wr_en` is asserted.
  - The FIFO is not full.
- After a successful write operation, the write pointer advances to the next memory location.

### Read Logic

- Data is read from the FIFO when:
  - `rd_en` is asserted.
  - The FIFO is not empty.
- After a successful read operation, the read pointer advances to the next memory location.

### Pointer Management

- Separate read and write pointers are used to track FIFO locations.
- Both pointers wrap around automatically after reaching the final memory location, implementing a circular buffer.

### Status Flags

#### Full Flag
- Asserted when the FIFO reaches its maximum storage capacity.
- Prevents additional write operations until data is read.

#### Empty Flag
- Asserted when no valid data is available in the FIFO.
- Prevents invalid read operations.

  ## Verification Environment

The FIFO is verified using a modular, object-oriented SystemVerilog testbench. The verification environment generates randomized transactions, drives them to the DUT, monitors the DUT outputs, and automatically compares the results against a reference model using a self-checking scoreboard.

                 +-------------+
                 | Generator   |
                 +------+------+
                        |
                        v
                 +-------------+
                 |   Driver    |
                 +------+------+
                        |
                        v
              +-------------------+
              |      FIFO DUT     |
              +-------------------+
                        |
                        v
                 +-------------+
                 |   Monitor   |
                 +------+------+
                        |
                        v
                 +-------------+
                 | Scoreboard  |
                 +-------------+
### Verification Components

| Component | Description |
|-----------|-------------|
| Interface | Connects the DUT with the verification environment using virtual interfaces. |
| Transaction | Defines the data packet and control signals used during verification. |
| Generator | Generates randomized read and write transactions. |
| Driver | Receives transactions from the generator and drives the DUT inputs. |
| Monitor | Observes DUT inputs and outputs and forwards the captured transactions to the scoreboard. |
| Scoreboard | Implements a reference queue model and compares DUT outputs with expected results. |
| Environment | Instantiates and connects all verification components and manages simulation execution. |

### Verification Flow

1. The **Generator** creates randomized transactions.
2. The **Driver** applies the transactions to the DUT through the interface.
3. The **Monitor** captures DUT activity and forwards it to the scoreboard.
4. The **Scoreboard** compares the DUT output with the reference model.
5. PASS/FAIL messages are reported automatically based on the comparison results.

### Verification Features

- Object-oriented SystemVerilog testbench
- Randomized transaction generation
- Mailbox-based communication
- Self-checking scoreboard
- Reference queue model for expected data
- Automatic PASS/FAIL reporting
- Modular and reusable verification components

  ## Simulation Results
  <img width="784" height="471" alt="FIFO_waveform" src="https://github.com/user-attachments/assets/a8f9f7cf-d25c-46d8-ad0a-64fc619d9175" />

## How to Run

1. Clone the repository:

2. Open **Xilinx Vivado** and create a new simulation project.

3. Add all RTL files from the `RTL/` directory.

4. Add all SystemVerilog testbench files from the `TB/` directory.

5. Set `testbench.sv` as the **top simulation module**.

6. Run **Behavioral Simulation**.

7. Observe the waveform and simulation console to verify:
   - FIFO write operations
   - FIFO read operations
   - Empty flag functionality
   - Scoreboard PASS/FAIL messages
  
  ## Tools Used

- **Verilog HDL** – RTL Design
- **SystemVerilog** – Verification Environment
- **Xilinx Vivado (XSim)** – Simulation and Waveform Analysis
- **Git** – Version Control
- **GitHub** – Source Code Management

  ## Future Improvements

- Add SystemVerilog Assertions (SVA) for protocol checking.
- Implement functional coverage to measure verification completeness.
- Develop a UVM-based verification environment.
- Add directed test cases for FIFO overflow and underflow conditions.
- Support configurable FIFO depth and data width through testbench configuration.
- Expand the verification suite with additional corner-case scenarios.

  ## Author

**Atharva Bagora**

- Electronics and Communication Engineering (ECE) Student
- MANIT Bhopal
- Interested in RTL Design and Design Verification
