`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/19 20:53:20
// Design Name: 
// Module Name: lab8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab8(
  input clk,
  input reset_n,
  input [3:0] usr_btn,
  output [3:0] usr_led,
  output LCD_RS,
  output LCD_RW,
  output LCD_E,
  output [3:0] LCD_D
);

// turn off all the LEDs
assign usr_led = 4'b0000;

wire btn_level, btn_pressed;
reg prev_btn_level;
reg [127:0] row_A = "Press BTN3 to   "; // Initialize the text of the first row. 
reg [127:0] row_B = "show a message.."; // Initialize the text of the second row.

localparam S_INIT = 3'b001;
localparam S_CRACK = 3'b010;
localparam S_SHOW = 3'b100;

parameter MEASURE_CLOCK_CYCLES=1 ;


reg [2:0] current_state,next_state;


LCD_module lcd0(
  .clk(clk),
  .reset(~reset_n),
  .row_A(row_A),
  .row_B(row_B),
  .LCD_E(LCD_E),
  .LCD_RS(LCD_RS),
  .LCD_RW(LCD_RW),
  .LCD_D(LCD_D)
);
    
debounce btn_db0(
  .clk(clk),
  .btn_input(usr_btn[3]),
  .btn_output(btn_level)
);

reg ct_rst_n;

wire [31:0] ct_answer;
wire ct_done;

wire [63:0]display_ct_answer;
assign display_ct_answer={
 "0"+ct_answer[28+:4],"0"+ct_answer[24+:4],"0"+ct_answer[20+:4],"0"+ct_answer[16+:4],
 "0"+ct_answer[12+:4],"0"+ct_answer[ 8+:4],"0"+ct_answer[ 4+:4],"0"+ct_answer[ 0+:4]};


reg [$clog2(MEASURE_CLOCK_CYCLES):0] counter;

reg [31:0] ct_time_BCD_Adder;

wire [31:0] BCDAdder_Answer;

wire [63:0]display_ct_time;
assign display_ct_time = {
  "0"+ct_time_BCD_Adder[28+:4],"0"+ct_time_BCD_Adder[24+:4],"0"+ct_time_BCD_Adder[20+:4],"0"+ct_time_BCD_Adder[16+:4],
  "0"+ct_time_BCD_Adder[12+:4],"0"+ct_time_BCD_Adder[ 8+:4],"0"+ct_time_BCD_Adder[ 4+:4],"0"+ct_time_BCD_Adder[ 0+:4]};

crack_top ct(
  .clk(clk),
  .rst_n(ct_rst_n),
  .answer(ct_answer),
  .done(ct_done)
);
always @(posedge clk ) begin
  if(current_state == S_INIT) ct_rst_n=0;
  else ct_rst_n=1;
end

BCDAdder BCDAdder(
  .A(ct_time_BCD_Adder),
  .B(1),
  .Answer(BCDAdder_Answer)
);

always @(posedge clk ) begin
  if(current_state ==S_INIT) counter <=0;
  else if(current_state == S_CRACK) counter<=(counter ==MEASURE_CLOCK_CYCLES)?0:counter+1;
  
end
always @(posedge clk ) begin
  if(current_state ==S_INIT)ct_time_BCD_Adder<=0;
  else if(current_state == S_CRACK && counter ==MEASURE_CLOCK_CYCLES) ct_time_BCD_Adder<=BCDAdder_Answer;
  
end
    
always @(posedge clk) begin
  if (~reset_n)
    prev_btn_level <= 1;
  else
    prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level == 1 && prev_btn_level == 0);

always @(posedge clk ) begin
  if(!reset_n)current_state <=S_INIT;
  else current_state<=next_state;
end

always @(*) begin
  case(current_state)
  S_INIT:next_state=(btn_pressed)?S_CRACK:S_INIT;

  S_CRACK:next_state=(ct_done)?S_SHOW:S_CRACK;

  S_SHOW:next_state=S_SHOW;
  endcase

end

always @(posedge clk) begin
  if (current_state == S_INIT) begin
    // Initialize the text when the user hit the reset button
    row_A <= "Press BTN3 to   ";
    row_B <= "crack password!!";
  end else if (current_state ==S_CRACK) begin
    row_A <= "Cracking........";
    row_B <= "Please wait!    ";
  end
  else if(current_state == S_SHOW)begin
    row_A <= {"Passwd: ",display_ct_answer};
    row_B <= {"Time:",display_ct_time,"0ns"};
  end
  else begin
    row_A <= "ERROR!!!ERROR!!!";
    row_B <= "ERROR!!!ERROR!!!";
  end
end

endmodule
