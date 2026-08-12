I2C Master-Slave Communication using Verilog HDL

1. Project Title

Inter-Integrated Circuit (I2C) Master-Slave Communication using Verilog HDL

2. Introduction

I2C stands for Inter-Integrated Circuit. It is a synchronous serial communication protocol commonly used for communication between integrated circuits.

I2C generally uses two communication lines:

- SCL – Serial Clock Line
- SDA – Serial Data Line

This project implements a simple I2C Master and Slave communication system using Verilog HDL.

3. Objective

The objectives of this project are:

- To understand the I2C communication protocol.
- To design an I2C Master using Verilog HDL.
- To design an I2C Slave using Verilog HDL.
- To transmit data between Master and Slave.
- To generate SCL and SDA signals.
- To verify the design using a testbench.
- To observe the communication using waveform simulation.

4. I2C Communication

I2C uses two main signals:

Signal| Full Form| Description
SCL| Serial Clock Line| Carries clock signal
SDA| Serial Data Line| Carries serial data

Both signals are shared between the Master and Slave.

5. I2C Block Diagram

              I2C MASTER
            +-------------+
            |             |
 Clock ---->|             |
 Start ---->|             |
 Data ----->|             |
            |             |
            +------+------+
                   |
             SCL  |  SDA
                   |
            +------+------+
            |             |
            |  I2C SLAVE  |
            |             |
            |             |
            +-------------+

6. Basic I2C Transaction

A typical I2C write transaction contains:

START
  ↓
7-bit Slave Address
  ↓
R/W Bit
  ↓
ACK
  ↓
Data Byte
  ↓
ACK
  ↓
STOP

7. Project Features

- I2C Master
- I2C Slave
- 7-bit slave address
- 8-bit data transmission
- SCL clock
- SDA bidirectional line
- START condition
- STOP condition
- ACK handling
- Testbench
- VCD waveform generation

8. Project Structure

I2C-Verilog-Project/
│
├── README.md
├── i2c_master.v
├── i2c_slave.v
├── i2c_top.v
├── i2c_tb.v
└── simulation/
    └── simulation_output.txt

9. Files Description

"i2c_master.v"

Contains the Verilog implementation of the I2C Master.

"i2c_slave.v"

Contains the Verilog implementation of the I2C Slave.

"i2c_top.v"

Connects the Master and Slave together.

"i2c_tb.v"

Provides clock, reset, address, and data inputs and verifies the I2C communication.

"simulation/simulation_output.txt"

Contains the expected console output.

10. Test Case

The testbench uses:

Slave Address = 1010000
Data          = A5

The Master transmits the data to the Slave.

Expected received data:

A5

11. Technologies Used

- Verilog HDL
- Icarus Verilog
- GTKWave
- GitHub

12. Simulation

Compile the project:

iverilog -o i2c_sim i2c_master.v i2c_slave.v i2c_top.v i2c_tb.v

Run the simulation:

vvp i2c_sim

The testbench generates:

i2c.vcd

Open the waveform:

gtkwave i2c.vcd

13. Waveform Signals

The following signals can be observed:

clk
reset
start
rw
slave_addr
data_in
busy
done
received_data
data_valid

The waveform can be used to observe the transmission of the address and data.

14. Expected Console Output

VCD info: dumpfile i2c.vcd opened for output.

---------------------------------------
       I2C MASTER-SLAVE SIMULATION
---------------------------------------
Slave Address = 1010000
Data to Send  = a5

---------------------------------------
Transmission Completed
Received Data = a5
Data Valid    = 1
---------------------------------------

15. Applications

I2C communication is commonly used for connecting:

- Sensors
- EEPROMs
- Real-time clocks
- Temperature sensors
- LCD controllers
- ADC/DAC devices
- Memory devices
- Microcontrollers
- FPGA peripherals

16. Advantages

1. Uses only two communication lines.
2. Supports multiple devices on the same bus.
3. Requires fewer pins than parallel communication.
4. Suitable for short-distance communication.
5. Supports address-based device selection.
6. Easy to interface with sensors and peripherals.

17. Limitations

- Generally intended for relatively short-distance board-level communication.
- Requires appropriate pull-up resistors in physical implementations.
- The simplified design in this project does not implement every feature of the full I2C specification.
- A production implementation should include robust arbitration, clock stretching, bus recovery, and error handling.

18. Result

The I2C Master-Slave communication system was successfully designed using Verilog HDL.

The testbench demonstrated transmission of the data byte "A5" to the simulated slave.

19. Conclusion

This project demonstrates the basic operation of the Inter-Integrated Circuit communication protocol using Verilog HDL.

The Master generates the communication sequence and transmits the address and data through the I2C bus. The Slave receives the transmitted data and provides the received-data output.

20. Future Improvements

The project can be extended by adding:

- I2C read operation
- Multiple slave devices
- Clock stretching
- Arbitration
- Error detection
- NACK handling
- Multiple-byte transmission
- Configurable clock frequency

21. Author

Your Name

Project: I2C Master-Slave Communication using Verilog HDL