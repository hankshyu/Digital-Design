# Lab7 Tasks


## In this lab, you will design a circuit to do 4 x 4 matrix multiplications.
- The user press BTN1 to start the circuit
- The circuit reads two 4 x 4 matrices from the SRAM, perform the multiplication, and print the output matrix through the UART to a terminal window
- Design Constraints: You must use no more than 16 multipliers to implement your circuit
- Each Atrix-7 35T FPGA on the Arty board has 90 20 ́18-bit multipliers

## Timing issues on Combinational Path
- A long arithmetic equation will be synthesized into a multi-level combinational circuit path
- You can divide a long combinational path into two or more always blocks to meet the timing constraint

## Setup Time and Hold Time
- To store values into flip-flops (registers) properly, the minimum allowable clock period Tmin is computed by Tmin = Tpath_delay + Tsetup
- Tpath_delay is the propagation delay through logics and wires
- Tsetup is the minimum time data must arrive at D before the next rising edge of clock (setup time)


## Module Specification
### Top module: lab7
<pre><code>module lab7(
  input  clk,
  input  reset_n,
  input  [3:0] usr_btn,
  output [3:0] usr_led,
  input  uart_rx,
  output uart_tx
);</code></pre>
