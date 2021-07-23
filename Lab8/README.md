# Lab8 Tasks

## In this lab, you will design a circuit to guess an 8-digit password scrambled with the MD5 hashing algorithm
- The password is composed of eight decimal digits coded in ASCII codes
- he MD5 hash code of the password will be given to you
- Your circuit must crack it, and display the original password and the time it takes for you to crack the password on the LCD module
- In order to crack the code as fast as possible, you should try to instantiate multiple copies of md5 circuit blocks and compute the hash code in parallel
- 
## MD5 Message-Digest Algorithm
- The algorithm takes as input a message of arbitrary length and produces as output a 128-bit "message digest" of the input.
- MD5 was developed by Ronald Rivest in 1991, and became a standard known as IETF RFC-1321
- [Memo about MD5 from IETF](https://www.ietf.org/rfc/rfc1321.txt)


## What to Do in Lab 5
- You must rewrite the md5 function and the cracker code using Verilog and implement it on the Arty board
- In your circuit, the password hash code should be declared as follows:
<pre><code>reg [0:127] passwd_hash = 128’hE9982EC5CA981BD365603623CF4B2277;</code></pre>
- Once the user press BTN3, your circuit will crack the password and show it on the LCD module

n Note: it takes an Intel i7-4770 PC 10 seconds to crack it!

## Module Specification
### Top module: lab4
<pre><code>module lab8(
  input clk,
  input reset_n,
  input [3:0] usr_btn,
  output [3:0] usr_led,
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D
);</code></pre>

## Experiments

Device          | Time  (us)
--------------|:-----
CPU i5-8259u   | 16,804,558 
CPU i7-4770 (given)  | 10,000,000
Single decode core on Arty| 21048
5 decode cores on Arty| 6699
10 decode cores on Arty| 939
25 decode cores on Arty| 0.35
25 decode cores on Arty| ~0.35



