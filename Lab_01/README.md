# Lab1 Tasks

## In this lab, you must design an 8-bit sequential binary multiplier and use the Vivado Simulator to verify your design
- You must design your multiplier using only adder, shifter, multiplexor, and gate-level operators. You can not use the multiplication operator of Verilog.
- The behavior of sequential binary multiplication of 10111 and 10011 is as follows:

<pre><code>      00010111 -> multiplicand  ́ 
   x  00010011 -> multiplier
---------------      
      00010111
     00010111
    00000000
   00000000
+ 00010111
---------------
  000110110101 -> product</pre></code>

## Module Specification

<pre><code>module SeqMultiplier(
    input wire clk,
    input wire enable,
    input wire [7:0] A,
    input wire [7:0] B,
    
    output wire [15:0] C
    );
</code></pre>
