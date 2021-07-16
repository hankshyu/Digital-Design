# Lab5 Tasks

## In this lab, you will use the sieve algorithm to find all the primes from 2 to 1021, and use the standard 1602 character LCD to display the prime numbers

## Memory Map of the LCD
- The LCD device can be treated as a 32-byte memory
<br/> -> Each memory cell corresponds to a character on the display
<br/> -> Writing an ASCII code to a cell will display the character on the corresponding location on the LCD

## The Sieve Algorithm
- The sieve algorithm is an interesting algorithm to find prime numbers using only addition operations:
<pre><code>#define LIMIT 1024
unsigned char primes[LIMIT];
memset((void *) primes, 1, sizeof(primes));
/* sieve algorithm */
for (idx = 2; idx < LIMIT; idx++)
{
    if (primes[idx])
    {
        for (jdx = idx+idx; jdx < LIMIT; jdx += idx)
        {
            primes[jdx] = 0;
         } 
     }
}</code></pre>

- After running the Sieve algorithm, the array primes[ ] contains flags of whether a number is a prime or not
- primes[n] == 1 means n is a prime number
- primes[n] == 0 means n is not a prime number


## What to Do in Lab 5
- Design a circuit to implement the sieve algorithm
- Once all primes between 0 and 1023 are found, the LCD will start to display prime numbers in the following format
- Roughly every 0.7 sec, the LCD scrolls up one number cyclically - If BTN3 is pressed, the scrolling direction will be reversed (scroll-up becomes scroll-down, and vice versa)

## Module Specification
### Top module: lab4
<pre><code>module lab4(
  input clk,
  input reset_n,
  input [3:0] usr_btn,
  output [3:0] usr_led,
  input uart_rx,
  output uart_tx
  );</code></pre>

