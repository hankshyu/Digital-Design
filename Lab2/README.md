# Lab2 Tasks

## In this lab, you will design a circuit to do a 3*3 matrix multiplication on Vivado Simulator.
- Two register arrays with of 3*3 matrices will be given to you in the sample Verilog simulation project.
- You must design a Verilog program to compute their multiplication, and print the result from the testbench.
- You must use no more than 9 multipliers to implement your circuit

## Module Requirements
<pre><code>module mmult(
  input  clk,
  input  reset_n,
  input  enable,
  input  [0:9*8-1] A_mat,
  input  [0:9*8-1] B_mat,
  output valid,

  output reg [0:9*17-1] C_mat 
);
</code></pre>
