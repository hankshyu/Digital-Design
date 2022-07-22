# Lab10 Tasks

## In this lab, you will implement a circuit that shows some graphics using the VGA video interface, your circuit must do the following things:
- Animates the moon to move across the picture with green- screen removal
- Adds fireworks animations to the picture

## VGA 
1. VGA stands for Video Graphics Array; it’s a video interface originally designed for CRT display
2. A VGA screen displays the entire screen pixel-by-pixel:
- The pixels of the screen are illuminated following a one- dimensional scanning path
- When pixel at (x, y) are “scanned,” your circuit must tell the screen what RGB color it should display

3. VGA is an analog interface
- 0v stands for the darkest pixel, 0.7v stands for the brightest
- The transition from darkest pixel to brightest pixel is not linear
- A video digital-to-analog converter (DAC) IC is usually used to convert digital pictures to analog VGA signals
- The most popular DAC is the ADV 7125 IC by Analog Devices

## Computer Graphics and Video Buffer
1. Processors are too slow to directly generate pixel data for video display
- Old arcade games are built using dedicated circuit to produce graphics
2. A break-through idea that enables software-based computer graphics is the concept of frame buffers (FB)
3. Computer systems usually use a single-port memory for video frame buffer
- Most memory bandwidth will be used by the video controller 
- CPU cannot make significant update to the content of the frame buffer without interrupting the video controller
- Double frame buffers can be used to solve this problem
4. Cycle Stealing from the Retrace Time
- Some systems do not have enough memory for double-buffering, other tricks must be used to modify the FB without interfering the video controller
- During the horizontal or vertical retrace periods, the video controller is NOT reading the FB
- FB data modifications during the sync periods will not corrupt video


## What to Do in Lab 10
- First, you must replace the green pixels of the moon image by the co-located background pixels
- Secondly, you must use your imaginations to createsome fireworks animations in the sky area

## Module Specification
### Top module: lab10
<pre><code>module lab10(
  input clk,
  input reset_n,
  input [3:0] usr_btn,
  output [3:0] usr_led,
  output VGA_HSYNC,
  output VGA_VSYNC,
  output [3:0] VGA_RED,
  output [3:0] VGA_GREEN,
  output [3:0] VGA_BLUE
);</code></pre>

