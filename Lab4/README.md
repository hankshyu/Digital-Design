# Lab4 Tasks

## In this lab, you will design a circuit to perform UART I/O. Your circuit will do the following things:

- Read two decimal number inputs from the UART/JTAG port connected to a PC terminal window. The number ranges from 0 to 65535.
- Compute the Greatest Common Divider (GCD) of the two numbers, and print the GCD to the UART terminal in hexadecimal format


## UART Physical Layer
- UART is a asynchronous transmission standard, thus, there is no common clock signal for synchronization
- The most popular physical layer for the UART transmission line is the RS-232 standard
<br/> -> Common baud rates for RS-232 signals range from 4800 bps to 115200 bps
<br/> -> RS-232 voltages are (–15V, –3V) for ‘1’ and (3V, 15V) for ‘0’

## UART Link Layer
- The serial line is 1 when it is idle
- The transmission starts with a start bit, which is 0, followed by data bits and an optional parity bit, and ends with stop bits, which are 1
- The number of data bits can be 6, 7, or 8
</br> -> The optional parity bit is used for error detection
</br> -> For odd parity, it is set to 0 when the data bits have an odd number of 1’s
</br> -> For even parity, it is set to 0 when the data bits have an even number of 1 's
- The number of stop bits can be 1, 1.5, or 2

## UART Controller
- A UART controller performs the following tasks
</br> -> Convert 8-bit parallel data to a serial bit stream and vice versa
</br> -> Insert (or remove) start bit, parity bit, and stop bit for every 8 bits of data
</br> -> Maintain a local clock for data transmission at correct rate
- A UART controller includes a transmitter, a receiver, and a baud rate generator
</br> -> The transmitter is essentially a special shift register that loads data in parallel and then shifts it out bit by bit at a specific rate
</br> -> The receiver, on the other hand, shifts in data bit by bit and then reassembles the data

## Out-of-Band Parameter Setting

- UART control parameters such as: bit-rate, #data bits, #stop bits, and types of parity-check must be set on both side of the serial transmission line before the communication begins
- Implicit clocks must be generated on both sides for correct transmission
</br> -> Bit rate per second (bps), or baud rate, is used to imply the clock on both end of the transmission line
</br> -> Baud rates must be two’s multiples of 1200, e.g., 2400, 4800, 9600, ..., 115200, etc.
</br> -> This clock is often called the baud rate generator

## Module Specification
### Top module: lab4
<pre><code>module lab4(
  input clk,
  input reset_n,
  input [3:0] usr_btn,
  output [3:0] usr_led,
  input uart_rx,
  output uart_tx
  );
</code></pre>
### Sub-module: gcd_calculator
<pre><code>module gcd_calculator(
  input clk,
  input rst_n,
  input enable,
  input [15:0] A,
  input [15:0] B,
  output [15:0] answer,
  output answer_available
  );
</code></pre>
### Sub-module: uart


<pre><code>module uart(
  input clk,              // The master clock for this module
  input rst,              // Synchronous reset.
  input rx,               // Incoming serial line
  output tx,              // Outgoing serial line
  input transmit,         // Signal to transmit
  input [7:0] tx_byte,    // Byte to transmit
  output received,        // Indicated that a byte has been received.
  output [7:0] rx_byte,   // Byte received
  output is_receiving,    // Low when receive line is idle.
  output is_transmitting, // Low when transmit line is idle.
  output recv_error       // Indicates error in receiving packet.
  );     
            </code></pre>
