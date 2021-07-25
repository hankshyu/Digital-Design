/* ------------------------------------------------------------------- */
/*  Modified from a Xilinx 1602 LCD controller by Chun-Jen Tsai.       */
/*  The timing of the original Xilinx controller does not work for the */
/*  majority of the inexpensive 1602 LCD modules in Taiwan.            */
/* ------------------------------------------------------------------- */
/*  The clock input 'clk' to the 1602 LCD controller shall be 100 MHz. */
/*  The controller only uses the 4-bit command mode to control the     */
/*  1602 LCD module. The output ports LCD_D[3:0] shall be physically   */
/*  connected to the module pins D7 ~ D4, respectively.                */
/*                                                           9/28/2016 */
/* ------------------------------------------------------------------- */

module LCD_module(
  input clk,
  input reset,
  input [127:0] row_A,
  input [127:0] row_B,
  output LCD_E,
  output LCD_RS,     // register select 
  output LCD_RW,     // read/write the lcd module 
  output [3:0] LCD_D // 1602 lcd data
  );

reg lcd_initialized = 0;
reg [25:0] init_count;
reg [3:0] init_d, icode;
reg init_e, init_rs, init_rw;

reg [24:0] text_count;
reg [3:0] text_d, tcode;
reg text_e, text_rs, text_rw;

// Signal drivers for the 1602 LCD module
assign LCD_E  = (lcd_initialized)? text_e  : init_e;
assign LCD_RS = (lcd_initialized)? text_rs : init_rs;
assign LCD_RW = (lcd_initialized)? text_rw : init_rw;
assign LCD_D  = (lcd_initialized)? text_d  : init_d;

// The initialization sequence (Run once at boot up).
always @(posedge clk) begin
  if (reset) begin
    lcd_initialized <= 0;
    init_count <= 0;
    init_d  <= 4'h0;
    init_e  <= 0;
    init_rs <= 0;
    init_rw <= 1;
  end
  else if (!lcd_initialized) begin
    init_count <= init_count + 1;

    // Enable the LCD when bit 21 of the init_count is 1
    // The command clock frequency is 100MHz/(2^22) = 23.84 Hz
    init_e  <= init_count[21];
    init_rs <= 0;
    init_rw <= 0;
    init_d  <= icode;

    case (init_count[25:22])
     0: icode <= 4'h3; // Power-on init sequence. It cause the LCD
     1: icode <= 4'h3; // to flicker if there are characters on the
     2: icode <= 4'h3; // display. So only do this once at the
     3: icode <= 4'h2; // begining.

    // Function Set. Set to 4-bit mode, 2 text lines, and 5x8 text
     4: icode <= 4'h2; // Upper nibble 0010
     5: icode <= 4'h8; // Lower nibble 1000

    // Entry Mode Set. Upper nibble: 0000, lower nibble: 0 1 I/D S
    // upper nibble: I/D bit (Incr 1, Decr 0), S bit (Shift 1, no shift 0)
     6: icode <= 4'h0; // Upper nibble 0000
     7: icode <= 4'h6; // Lower nibble 0110: Incr, Shift disabled

    // Display On/Off. Upper nibble: 0000, lower nibble 1 D C B
    // D: 1, display on, 0 off
    // C: 1, show cursor, 0 don't
    // B: 1, cursor blinks (if shown), 0 don't blink (if shown)
     8: icode <= 4'h0; // Upper nibble 0000
     9: icode <= 4'hC; // Lower nibble 1100

    // Clear Display. Upper nibble 0000, lower nibble 0001
    10: icode <= 4'h0; // Upper nibble 0000
    11: icode <= 4'h1; // Lower nibble 0001

    // We should read the Busy Flag and Address after each command
    // to determine whether we can move on to the next command.
    // However, our init counter runs quite slowly that most 1602
    // LCDs should have plenty of time to finish each command.
    default: lcd_initialized <= 1;
    endcase
  end
end

// The text refreshing sequence.
always @(posedge clk) begin
  if (reset) begin
    text_count <= 0;
    text_d  <= 4'h0;
    text_e  <= 0;
    text_rs <= 0;
    text_rw <= 0;
  end
  else if (lcd_initialized) begin
    text_count <= (text_count[24:18] < 68)? text_count + 1 : 0;

    // Refresh (enable) the LCD when bit 17 of the text_count is 1
    // The command clock frequency is 100MHz/(2^18) = 381.47 Hz
    // The screen refresh frequency is 381.47Hz/68 = 5.60 Hz
    text_e  <= text_count[17];
    text_rs <= 1;
    text_rw <= 0;
    text_d <= tcode;

    case (text_count[24:18])
    // Position the cursor to the start of the first line.
    // Upper nibble is 1???, where ??? is the highest 3 bits of
    // the RAM address to move the cursor to.
    // Lower nibble is the lower 4 bits of the RAM address.
     0: { text_rs, text_rw, tcode } <= 6'b001000;
     1: { text_rs, text_rw, tcode } <= 6'b000000;

    // Print chararters by writing data to DD RAM (or CG RAM).
    // The cursor will advance to the right end of the screen.
     2: tcode <= row_A[127:124];
     3: tcode <= row_A[123:120];
     4: tcode <= row_A[119:116];
     5: tcode <= row_A[115:112];
     6: tcode <= row_A[111:108];
     7: tcode <= row_A[107:104];
     8: tcode <= row_A[103:100];
     9: tcode <= row_A[99 :96 ];
    10: tcode <= row_A[95 :92 ];
    11: tcode <= row_A[91 :88 ];
    12: tcode <= row_A[87 :84 ];
    13: tcode <= row_A[83 :80 ];
    14: tcode <= row_A[79 :76 ];
    15: tcode <= row_A[75 :72 ];
    16: tcode <= row_A[71 :68 ];
    17: tcode <= row_A[67 :64 ];
    18: tcode <= row_A[63 :60 ];
    19: tcode <= row_A[59 :56 ];
    20: tcode <= row_A[55 :52 ];
    21: tcode <= row_A[51 :48 ];
    22: tcode <= row_A[47 :44 ];
    23: tcode <= row_A[43 :40 ];
    24: tcode <= row_A[39 :36 ];
    25: tcode <= row_A[35 :32 ];
    26: tcode <= row_A[31 :28 ];
    27: tcode <= row_A[27 :24 ];
    28: tcode <= row_A[23 :20 ];
    29: tcode <= row_A[19 :16 ];
    30: tcode <= row_A[15 :12 ];
    31: tcode <= row_A[11 :8  ];
    32: tcode <= row_A[7  :4  ];
    33: tcode <= row_A[3  :0  ];

    // position the cursor to the start of the 2nd line
    34: { text_rs, text_rw, tcode } <= 6'b001100;
    35: { text_rs, text_rw, tcode } <= 6'b000000;

    // Print chararters by writing data to DD RAM (or CG RAM).
    // The cursor will advance to the right end of the screen.
    36: tcode <= row_B[127:124];
    37: tcode <= row_B[123:120];
    38: tcode <= row_B[119:116];
    39: tcode <= row_B[115:112];
    40: tcode <= row_B[111:108];
    41: tcode <= row_B[107:104];
    42: tcode <= row_B[103:100];
    43: tcode <= row_B[99 :96 ];
    44: tcode <= row_B[95 :92 ];
    45: tcode <= row_B[91 :88 ];
    46: tcode <= row_B[87 :84 ];
    47: tcode <= row_B[83 :80 ];
    48: tcode <= row_B[79 :76 ];
    49: tcode <= row_B[75 :72 ];
    50: tcode <= row_B[71 :68 ];
    51: tcode <= row_B[67 :64 ];
    52: tcode <= row_B[63 :60 ];
    53: tcode <= row_B[59 :56 ];
    54: tcode <= row_B[55 :52 ];
    55: tcode <= row_B[51 :48 ];
    56: tcode <= row_B[47 :44 ];
    57: tcode <= row_B[43 :40 ];
    58: tcode <= row_B[39 :36 ];
    59: tcode <= row_B[35 :32 ];
    60: tcode <= row_B[31 :28 ];
    61: tcode <= row_B[27 :24 ];
    62: tcode <= row_B[23 :20 ];
    63: tcode <= row_B[19 :16 ];
    64: tcode <= row_B[15 :12 ];
    65: tcode <= row_B[11 :8  ];
    66: tcode <= row_B[7  :4  ];
    67: tcode <= row_B[3  :0  ];
    default: { text_rs, text_rw, tcode } <= 6'h10; // default to read mode.
    endcase
  end
end

endmodule
