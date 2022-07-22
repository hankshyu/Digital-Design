//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory System Integration and Silicon Implementation
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   2012 DLAB Course
//   Lab08      : PING_PONG_GAME
//   Author     : Szu-Chi, Chung (phonchi@si2lab.org) (v1.0)
//                
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : vga_sync.v
//   Module Name : vga_sync
//   Release version : v1.0 (Release Date: Apr-2012)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
module vga_sync(
  input clk, 
  input reset,
  output wire oHS, 
  output wire oVS, 
  output wire visible, 
  output wire p_tick,
  output wire [9:0] pixel_x, 
  output wire [9:0] pixel_y
  );

   // VGA 640-by-480 sync parameters
   parameter HD = 640; // horizontal display area
   parameter HF = 48 ; // h. front (left) border
   parameter HB = 16 ; // h. back (right) border
   parameter HR = 96 ; // h. retrace
   parameter VD = 480; // vertical display area
   parameter VF = 10;  // v. front (top) border
   parameter VB = 33;  // v. back (bottom) border
   parameter VR = 2;   // v. retrace

   // mod-2 counter
   reg mod2_reg;
   wire mod2_next;
   // sync counters
   reg [9:0] h_count_reg, h_count_next;
   reg [9:0] v_count_reg, v_count_next;
   // output buffer
   reg v_sync_reg, h_sync_reg;
   wire v_sync_next, h_sync_next;
   // status signal
   wire h_end, v_end, pixel_tick;

   // registers
   always @(posedge clk) begin
      if (reset)
         begin
            mod2_reg <= 1'b0;
            v_count_reg <= 0;
            h_count_reg <= 0;
            v_sync_reg <= 1'b0;
            h_sync_reg <= 1'b0;
         end
      else
         begin
            mod2_reg <= mod2_next;
            v_count_reg <= v_count_next;
            h_count_reg <= h_count_next;
            v_sync_reg <= v_sync_next;
            h_sync_reg <= h_sync_next;
         end
	end
   // mod-2 circuit to generate 25 MHz enable tick
   assign mod2_next = ~mod2_reg;
   assign pixel_tick = mod2_reg;

   // end of horizontal counter (799)
   assign h_end = (h_count_reg==(HD+HF+HB+HR-1));
   // end of vertical counter (524)
   assign v_end = (v_count_reg==(VD+VF+VB+VR-1));

   // next-state logic of mod-800 horizontal sync counter
   always @(*) begin
      if (pixel_tick) begin  // 25 MHz pulse
         if (h_end)
            h_count_next = 0;
         else
            h_count_next = h_count_reg + 1;
      end
	  else
         h_count_next = h_count_reg;
	end
   // next-state logic of mod-525 vertical sync counter
   always @(*) begin
      if (pixel_tick & h_end) begin // 25 MHz pulse
         if (v_end)
            v_count_next = 0;
         else
            v_count_next = v_count_reg + 1;
	  end
      else
         v_count_next = v_count_reg;
	end
   // horizontal and vertical sync, buffered to avoid glitch
   // h_sync_next asserted between 656 and 751
   assign h_sync_next = (h_count_reg>=(HD+HB) &&
                         h_count_reg<=(HD+HB+HR-1));
   // vh_sync_next asserted between 490 and 491
   assign v_sync_next = (v_count_reg>=(VD+VB) &&
                         v_count_reg<=(VD+VB+VR-1));

   // video on/off
   assign visible = (h_count_reg<HD) && (v_count_reg<VD);

   // output
   assign oHS = h_sync_reg;
   assign oVS = v_sync_reg;
   assign pixel_x = h_count_reg;
   assign pixel_y = v_count_reg;
   assign p_tick = pixel_tick;

endmodule
