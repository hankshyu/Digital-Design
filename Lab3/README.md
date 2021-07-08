# Lab2 Tasks

## In this lab, you will design a circuit to do a 3x3 matrix multiplication on Vivado Simulator.
- Two register arrays with of 3x3 matrices will be given to you in the sample Verilog simulation project.
- You must design a Verilog program to compute their multiplication, and print the result from the testbench.
- You must use no more than 9 multipliers to implement your circuit
<br/><br/>

- A 3x3 matrix multiplication is composed of 9 inner products:

- Computation of AxB: </t></t> <strong>  Cij = Sigma(Aik * Bkj)</strong>

<pre><code>|a00 a01 a02|   |b00 b01 b02|   |c00 c01 c02|
|a10 a11 a12| x |b10 b11 b12| = |c10 c11 c12|
|a20 a21 a22|   |b20 b21 b22|   |c20 c21 c22|</code></pre>





## Module Specification
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
