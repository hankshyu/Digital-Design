# Lab9 Tasks

## In this lab, you will design a correlation filter circuit and use it to detect the presence of a waveform
- Your circuit has an SRAM that stores a 1-D waveform f[×] of 1024 data samples and a 1-D pattern g[×] of 64 data samples; each sample in f[×] and g[×] is an 8-bit signed number
- When the user hit BTN0, your circuit will compute the cross- correlation function Cfg[×] between f[×] and g[×], and display the maximal value of Cfg[×] and its position on the 1602 LCD

## Correlation filter
1. Mathematically, a correlation filter is the sliding inner product between two signals f(x) and g(x):
2. If f(x) and g(x) are the same signal, it is called auto-correlation

- The distances between the peaks of the auto-correlation function of a noisy periodic signals can be used to estimate the period of the signal
3. If f(x) and g(x) are different signals, it is called cross-correlation

- The maximal location of the cross-correlation function between g(x) and f(x) means that a signal most similar to g(x) is located at x0 of f(x)
4. C Model of Correlation:
<pre><code>char f[1024] = { ... };
char g[64] = { ... };
int  c[960];
int x, y, k, sum, max, max_pos;
max = max_pos = 0;
for (x = 0; x < 1024 - 64; x++)
{
    sum = 0;
    for (k = 0; k < 64; k++)
    {
        sum += f[k+x] * g[k];
    }
    c[x] = sum;
    if (sum > max) max = sum, max_pos = x;
}</code></pre>
## What to Do in Lab 9
- In this lab, f[0:1023] and g[0:63] are 8-bit signed arrays stored in an SRAM block, and the correlation function cfg[0:959] has 960 elements
- You can use a chain of shift registers to read data from the SRAM, begin at address 0 and ends at 1023
- If the user presses BTN0, the correlation circuit should be activated. When the circuit is done, the maximal value of the correlation and its location should be displayed on the LCD




## Module Specification
### Top module: lab8
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





