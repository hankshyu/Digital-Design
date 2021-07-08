# Lab3 Tasks

## In this lab, you will use the FPGA development board “Arty” to implement a simple I/O control circuit

👉 Your circuit should have a 4-bit counter register
- The counter value is set to zero upon reset
- he counter value is a signed value in 2’complement format n The 4 LEDs display the 4 counter bits at all time
<br/>
👉 Push-buttons #0 and #1 are used to decrease/increase the counter value: 

- Push the BTN1/BTN0 increases/decreases the counter by 1
- If the counter value becomes grater than 7, it is truncated to 7;
- If the value is smaller than –8, it is set to –8
<br/>
👉 Push-buttons #2 and #3 are used to control the brightness of the LEDs

- BTN3 makes the LED brighter and BTN2 makes it darker


## In reality, however, the signal value oscillates between 0 and 1 several times before it stabilizes. This is called the bouncing behavior of a hardware button.
- We may set a timer to wait out the bouncing period

## The LED device in the Arty board can only be fully lit (full power) or turned off (zero power).
- To trick your eyes to see different levels of brightness, you can send a PWM signal to its power input
- A PWM input to the LED turns it on-an-off quickly
- The persistence of human visions will not see flickering but only different levels of brightness, as long as your PWM frequency is high enough


## Module Specification
<pre><code>module lab3(
  input  clk,            // System clock at 100 MHz
  input  reset_n,        // System negative reset signal
  input  [3:0] usr_btn,  // Four user pushbuttons
  output [3:0] usr_led   // Four yellow LEDs
);
assign usr_led = usr_btn;
endmodule
</code></pre>
