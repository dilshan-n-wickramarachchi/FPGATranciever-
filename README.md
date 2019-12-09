# FPGATranciever
Implement UART communication using FPGA board and verify of the code by using testbench simulations and apply in FPGA development board. Verilog language was used to implement the modules in FPGA.

#### Group Members 
1. 150396M : L.H.D. Malinda
2. 150488X : P.N.S.A. Rajakaruna
3. 150587B : T.M.L.R.D Seram
4. 150684U : W.A.D.N. Wickramarachchi

#### Motivation 
Understand the basics of HDL, verilog, FPGA 

### Main Modules
The Transceiver implemented on the fpga board contains the main modules,
#### 1. Baud-rate
  Module which the scales the input clock signals. Since input clock frequency is 50MHz it will perform scaling operations and scalled clock signals. These clock signals used to control transmitter and receiver. 
  
#### 2. Transmitter 
  Reads the input signal through GPIO pins (13 -27) and when transmitter button in pressed it will start writing the input data stream to tx line. This module is operated by a clock signal modified through baud-rate module. When transmitting data, initially transmittion signal is given through pins and then push button is pressed. Then red(connected externally) light will turn on indicating that data is written to transmission line(i.e. line is busy). When red light turned off data will transmit.
  
#### 3. Receiver 
  Reads data stream received and represents the 8 data bits using on board led lights. This module is operated by a clock signal modified through baud-rate module and switch which turn off/on the receiver. Green led indicates whether receiver is turned on.
