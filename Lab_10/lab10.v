`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of Computer Science, National Chiao Tung University
// Engineer: Chun-Jen Tsai
//
// Create Date: 2017/08/25 14:29:54
// Design Name:
// Module Name: lab10
// Project Name:
// Target Devices:
// Tool Versions:
// Description: A circuit that show the animation of a moon moving across a city
//              night view on a screen through the VGA interface of Arty I/O card.
//
// Dependencies: vga_sync, clk_divider, sram
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module lab10(input clk,
             input reset_n,
             input [3:0] usr_btn,
             output [3:0] usr_led,
             output VGA_HSYNC,
             output VGA_VSYNC,
             output [3:0] VGA_RED,
             output [3:0] VGA_GREEN,
             output [3:0] VGA_BLUE);
    
    // Declare system variables
    reg  [33:0] moon_clock;
    reg  [28:0] firework_clock;
    wire [9:0]  pos;
    wire [2:0]  firework_count;
    wire        moon_region;
    
    // declare SRAM control signals
    wire [16:0] sram_addr;
    wire [11:0] data_in;
    wire [11:0] data_out;
    wire        sram_we, sram_en;

    //SRAM control signals of moon and the firework
    wire [11:0] sram_moon_addr;
    wire [11:0] data_moon_out;
    wire [13:0] sram_firework_addr;
    wire [11:0] data_firework_out;
    
    // General VGA control signals
    wire vga_clk;       // 50MHz clock for VGA control
    wire video_on;      // when video_on is 0, the VGA controller is sending
    // synchronization signals to the display device.
    
    wire pixel_tick;    // when pixel tick is 1, we must update the RGB value
    // based for the new coordinate (pixel_x, pixel_y)
    
    wire [9:0] pixel_x; // x coordinate of the next pixel (between 0 ~ 639)
    wire [9:0] pixel_y; // y coordinate of the next pixel (between 0 ~ 479)
    
    reg  [11:0] rgb_reg;  // RGB value for the current pixel
    reg  [11:0] rgb_next; // RGB value for the next pixel
    
    // Application-specific VGA signals
    reg  [16:0] pixel_addr;
    reg  [11:0] pixel_moon_addr;
    reg  [13:0] pixel_firework_addr ;
    
    // Declare the video buffer size
    localparam VBUF_W = 320; // video buffer width
    localparam VBUF_H = 240; // video buffer height
    
    // Instiantiate a VGA sync signal generator
    vga_sync vs0(
      .clk(vga_clk), 
      .reset(~reset_n), 
      .oHS(VGA_HSYNC), 
      .oVS(VGA_VSYNC),
      .visible(video_on), 
      .p_tick(pixel_tick),
      .pixel_x(pixel_x), 
      .pixel_y(pixel_y)
    );
    
    clk_divider#(2) clk_divider0(
      .clk(clk),
      .reset(~reset_n),
      .clk_out(vga_clk)
    );
    
    // ------------------------------------------------------------------------
    // The following code describes an initialized SRAM memory block that
    // stores an 320x240 12-bit city image, plus a 64x40 moon image.
    sram #(
      .DATA_WIDTH(12),
      .ADDR_WIDTH(17),
      .RAM_SIZE(VBUF_W*VBUF_H)
    )ram_backbround(
      .clk(clk), 
      .we(sram_we), 
      .en(sram_en),
      .addr(sram_addr), 
      .data_i(data_in), 
      .data_o(data_out)
    );

    sram_moon #(
      .DATA_WIDTH(12),
      .ADDR_WIDTH(12),
      .RAM_SIZE(64*40)
    )ram_moon(
      .clk(clk), 
      .we(sram_we), 
      .en(sram_en),
      .addr(sram_moon_addr), 
      .data_i(data_in), 
      .data_o(data_moon_out)
    );

    sram_firework #(
      .DATA_WIDTH(12),
      .ADDR_WIDTH(14),
      .RAM_SIZE(6*50*40)
    )ram_firework(
      .clk(clk), 
      .we(sram_we), 
      .en(sram_en),
      .addr(sram_firework_addr), 
      .data_i(data_in), 
      .data_o(data_firework_out)
    );

    assign sram_we = usr_btn[3]; // In this demo, we do not write the SRAM. However,if you set 'we' to 0, Vivado fails to synthesize
    //ram0 as a BRAM -- this is a bug in Vivado.
    assign sram_en   = 1;          // Here, we always enable the SRAM block.
    assign sram_addr = pixel_addr;
    assign data_in   = 12'h000; // SRAM is read-only so we tie inputs to zeros.
    // End of the SRAM memory block.

    assign sram_moon_addr = pixel_moon_addr;
    assign sram_firework_addr = pixel_firework_addr;

    // ------------------------------------------------------------------------
    
    // VGA color pixel generator
    assign {VGA_RED, VGA_GREEN, VGA_BLUE} = rgb_reg;
    
    // ------------------------------------------------------------------------
    // An animation clock for the motion of the moon, upper bits of the
    // moon clock is the x position of the moon in the VGA screen
    assign pos = moon_clock[33:24];

    assign firework_count = firework_clock[28:26];

    
    always @(posedge clk) begin
        if (~reset_n || moon_clock[33:25] > VBUF_W + 64)
            moon_clock <= 0;
        else
            moon_clock <= moon_clock + 1;
    end

    always @(posedge clk) begin
      if (~reset_n || firework_count > 5 || moon_clock == 0)
          firework_clock <= 0;
      else
          firework_clock <= firework_clock + 1;
    end

    // End of the animation clock code.
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    // Video frame buffer address generation unit (AGU) with scaling control
    // Note that the width x height of the moon image is 64x40, when scaled
    // up to the screen, it becomes 128x80
    assign moon_region = pixel_y >= 0 && pixel_y < 80 &&
    (pixel_x + 127) >= pos && pixel_x < pos + 1;

    assign firework_region = pixel_y >= 40 && pixel_y <= 120 &&
    pixel_x >= 320 && pixel_x <= 420;
    
    always @ (posedge clk) begin
        if (~reset_n)
            pixel_addr <= 0;
        else
        // Scale up a 320x240 image for the 640x480 display.
        // (pixel_x, pixel_y) ranges from (0,0) to (639, 379)
          pixel_addr <= (pixel_y >> 1) * VBUF_W + (pixel_x >> 1);
    end


    always @(posedge clk ) begin
      if(~reset_n)
        pixel_moon_addr <= 0;
      else
        pixel_moon_addr <= ((pixel_y&10'h3FE)<<5) + ((pixel_x-pos+127)>>1);
    end

    always @ (posedge clk) begin
      if (~reset_n)
        pixel_firework_addr <= 0;
      else
        pixel_firework_addr <= firework_count*50*40 + ((pixel_y-40) >> 1) * 50 + ((pixel_x-320) >> 1);
    end

    // End of the AGU code.
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    // Send the video data in the sram to the VGA controller
    
    always @(posedge clk) begin
        if (pixel_tick) rgb_reg <= rgb_next;
    end
    
    always @(*) begin
        if (~video_on)
            rgb_next = 12'h000; // Synchronization period, must set RGB values to zero.
        else if(firework_region && data_firework_out != 12'h000)
          rgb_next = data_firework_out;           
        
        else if(moon_region && data_moon_out != 12'h0f0)
          rgb_next = data_moon_out;
        else 
          rgb_next = data_out;
    end
    // End of the video data display code.
    // ------------------------------------------------------------------------
    
endmodule
