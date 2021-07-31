`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of CS, National Chiao Tung University
// Engineer: Chun-Jen Tsai
// 
// Create Date: 2017/04/27 15:06:57
// Design Name: UART I/O example for Arty
// Module Name: lab4
// Project Name: 
// Target Devices: Xilinx FPGA @ 100MHz
// Tool Versions: 
// Description: 
// 
// The parameters for the UART controller are 9600 baudrate, 8-N-1-N
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module lab7(
  input  clk,
  input  reset_n,
  input  [3:0] usr_btn,
  output [3:0] usr_led,
  input  uart_rx,
  output uart_tx);

localparam [2:0] S_MAIN_INIT = 0;
localparam [2:0] S_MAIN_PROMPT = 1;
localparam [2:0] S_MAIN_WAIT_KEY = 2;
localparam [2:0] S_MAIN_CAL = 3;
localparam [2:0] S_MAIN_WRITE = 4;
localparam [2:0] S_MAIN_HELLO = 5;

localparam [1:0] S_UART_IDLE = 0, S_UART_WAIT = 1,
                 S_UART_SEND = 2, S_UART_INCR = 3;
localparam INIT_DELAY = 100_000; // 1 msec @ 100 MHz
localparam MEM_SIZE = 169;
localparam PROMPT_STR = 0;
localparam HELLO_STR = 22;

// declare system variables
wire print_enable, print_done;
reg [$clog2(MEM_SIZE):0] send_counter;
reg [2:0] P, P_next;
reg [1:0] Q, Q_next;
reg [$clog2(INIT_DELAY):0] init_counter;
reg [7:0] data[0:MEM_SIZE-1];

// declare UART signals
wire transmit;
wire received;
wire [7:0] rx_byte;
wire [7:0] tx_byte;
wire is_receiving;
wire is_transmitting;
wire recv_error;

//declare btn related signals
wire btn_level;
wire btn_pressed;
reg  prev_btn_level;

  // declare matrix_cal signals
  wire [287:0] matrix_cal_answer;
  wire matrix_cal_done;
/* The UART device takes a 100MHz clock to handle I/O at 9600 baudrate */
uart uart(
  .clk(clk),
  .rst(~reset_n),
  .rx(uart_rx),
  .tx(uart_tx),
  .transmit(transmit),
  .tx_byte(tx_byte),
  .received(received),
  .rx_byte(rx_byte),
  .is_receiving(is_receiving),
  .is_transmitting(is_transmitting),
  .recv_error(recv_error)
);

matrix_cal matrix_cal(
.clk(clk),
.rst_n(reset_n),
.btn(usr_btn),
.answer(matrix_cal_answer),
.done(matrix_cal_done)
);

debounce debounce(
.clk(clk),
.btn_input(usr_btn[1]),
.btn_output(btn_level)
);

always @(posedge clk) begin
    if (~reset_n)
        prev_btn_level <= 0;
    else
        prev_btn_level <= btn_level;
end

assign btn_pressed = (btn_level == 1 && prev_btn_level == 0)? 1 : 0;
// Initializes some strings.
// System Verilog has an easier way to initialize an array,
// but we are using Verilog 2005 :(
//
initial begin

    { data[ 0], data[ 1], data[ 2], data[ 3], data[ 4], data[ 5], data[ 6], data[ 7],
      data[ 8], data[ 9], data[10], data[11], data[12], data[13], data[14], data[15],
      data[16], data[17], data[18], data[19], data[20], data[21] }
    <= { 8'h0D, 8'h0A, "Press BTN1 to start", 8'h00 };


    { data[ 22], data[ 23], data[ 24], data[ 25], data[ 26], data[ 27], data[ 28], data[ 29], 
      data[ 30], data[ 31], data[ 32], data[ 33], data[ 34], data[ 35], data[ 36], data[ 37], 
      data[ 38], data[ 39], data[ 40], data[ 41], data[ 42], data[ 43], data[ 44], data[ 45], 
      data[ 46], data[ 47], data[ 48], data[ 49], data[ 50], data[ 51], data[ 52], data[ 53], 
      data[ 54], data[ 55], data[ 56], data[ 57], data[ 58], data[ 59], data[ 60], data[ 61], 
      data[ 62], data[ 63], data[ 64], data[ 65], data[ 66], data[ 67], data[ 68], data[ 69], 
      data[ 70], data[ 71], data[ 72], data[ 73], data[ 74], data[ 75], data[ 76], data[ 77],
      data[ 78], data[ 79], data[ 80], data[ 81], data[ 82], data[ 83], data[ 84], data[ 85], 
      data[ 86], data[ 87], data[ 88], data[ 89], data[ 90], data[ 91], data[ 92], data[ 93], 
      data[ 94], data[ 95], data[ 96], data[ 97], data[ 98], data[ 99], data[100], data[101], 
      data[102], data[103], data[104], data[105], data[106], data[107], data[108], data[109], 
      data[110], data[111], data[112], data[113], data[114], data[115], data[116], data[117], 
      data[118], data[119], data[120], data[121], data[122], data[123], data[124], data[125],
      data[126], data[127], data[128], data[129], data[130], data[131], data[132], data[133], 
      data[134], data[135], data[136], data[137], data[138], data[139], data[140], data[141], 
      data[142], data[143], data[144], data[145], data[146], data[147], data[148], data[149], 
      data[150], data[151], data[152], data[153], data[154], data[155], data[156], data[157], 
      data[158], data[159], data[160], data[161], data[162], data[163], data[164], data[165], 
      data[166], data[167], data[168] }
    <= { 8'h0D, 8'h0A, "The result is:", 8'h0D, 8'h0A,
        "[ ", "00001, ", "00002, ", "00003, ", "00004", " ]", 8'h0D, 8'h0A,
        "[ ", "00005, ", "00006, ", "00007, ", "00008", " ]", 8'h0D, 8'h0A,
        "[ ", "00009, ", "00010, ", "00011, ", "00012", " ]", 8'h0D, 8'h0A,
        "[ ", "00013, ", "00014, ", "00015, ", "00016", " ]", 8'h0D, 8'h0A, 8'h00 };

  end

  always @(posedge clk ) begin
      if(P == S_MAIN_WRITE)
        { data[ 42], data[ 43], data[ 44], data[ 45], data[ 46] } <= BtoA(matrix_cal_answer[  0+:18]);
        { data[ 49], data[ 50], data[ 51], data[ 52], data[ 53] } <= BtoA(matrix_cal_answer[ 18+:18]);
        { data[ 56], data[ 57], data[ 58], data[ 59], data[ 60] } <= BtoA(matrix_cal_answer[ 36+:18]);
        { data[ 63], data[ 64], data[ 65], data[ 66], data[ 67] } <= BtoA(matrix_cal_answer[ 54+:18]);
        { data[ 74], data[ 75], data[ 76], data[ 77], data[ 78] } <= BtoA(matrix_cal_answer[ 72+:18]);
        { data[ 81], data[ 82], data[ 83], data[ 84], data[ 85] } <= BtoA(matrix_cal_answer[ 90+:18]);
        { data[ 88], data[ 89], data[ 90], data[ 91], data[ 92] } <= BtoA(matrix_cal_answer[108+:18]);
        { data[ 95], data[ 96], data[ 97], data[ 98], data[ 99] } <= BtoA(matrix_cal_answer[126+:18]);
        { data[106], data[107], data[108], data[109], data[110] } <= BtoA(matrix_cal_answer[144+:18]);
        { data[113], data[114], data[115], data[116], data[117] } <= BtoA(matrix_cal_answer[162+:18]);
        { data[120], data[121], data[122], data[123], data[124] } <= BtoA(matrix_cal_answer[180+:18]);
        { data[127], data[128], data[129], data[130], data[131] } <= BtoA(matrix_cal_answer[198+:18]);
        { data[138], data[139], data[140], data[141], data[142] } <= BtoA(matrix_cal_answer[216+:18]);
        { data[145], data[146], data[147], data[148], data[149] } <= BtoA(matrix_cal_answer[234+:18]);
        { data[152], data[153], data[154], data[155], data[156] } <= BtoA(matrix_cal_answer[252+:18]);
        { data[159], data[160], data[161], data[162], data[163] } <= BtoA(matrix_cal_answer[270+:18]);
  end 


function [39:0] BtoA;
  input[17:0] binary;

  begin
  BtoA[ 0+:8] = binarytoAscii(binary[0+:4]);
  BtoA[ 8+:8] = binarytoAscii(binary[4+:4]);
  BtoA[16+:8] = binarytoAscii(binary[8+:4]);
  BtoA[24+:8] = binarytoAscii(binary[12+:4]);
  BtoA[32+:8] = binarytoAscii(binary[17:16]);
end

endfunction

function[7:0] binarytoAscii;
  input [3:0] binary;
  begin
  binarytoAscii = (binary>9)?"A"+binary-10:"0"+binary;
  end
endfunction

// Combinational I/O logics
assign usr_led = usr_btn;
assign tx_byte = data[send_counter];

// ------------------------------------------------------------------------
// Main FSM that reads the UART input and triggers
// the output of the string "Hello, World!".
always @(posedge clk) begin
  if (~reset_n) P <= S_MAIN_INIT;
  else P <= P_next;
end

always @(*) begin // FSM next-state logic
  case (P)
    S_MAIN_INIT: // Wait for initial delay of the circuit.
	   if (init_counter < INIT_DELAY) P_next = S_MAIN_INIT;
		else P_next = S_MAIN_PROMPT;
    S_MAIN_PROMPT: // Print the prompt message.
      if (print_done) P_next = S_MAIN_WAIT_KEY;
      else P_next = S_MAIN_PROMPT;
    S_MAIN_WAIT_KEY: // wait for <Enter> key.
      if (btn_pressed) P_next = S_MAIN_CAL;
      else P_next = S_MAIN_WAIT_KEY;

    S_MAIN_CAL:P_next = (matrix_cal_done)?S_MAIN_WRITE:S_MAIN_CAL;

    S_MAIN_WRITE:P_next = S_MAIN_HELLO;

    S_MAIN_HELLO: // Print the hello message.
      if (print_done) P_next = S_MAIN_INIT;
      else P_next = S_MAIN_HELLO;
  endcase
end

// FSM output logics: print string control signals.

assign print_enable = (P != S_MAIN_PROMPT && P_next == S_MAIN_PROMPT) ||
                  (P == S_MAIN_WRITE && P_next == S_MAIN_HELLO);
assign print_done = (tx_byte == 8'h0);

// Initialization counter.
always @(posedge clk) begin
  if (P == S_MAIN_INIT) init_counter <= init_counter + 1;
  else init_counter <= 0;
end
// End of the FSM of the print string controller
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
// FSM of the controller to send a string to the UART.
always @(posedge clk) begin
  if (~reset_n) Q <= S_UART_IDLE;
  else Q <= Q_next;
end

always @(*) begin // FSM next-state logic
  case (Q)
    S_UART_IDLE: // wait for the print_string flag
      if (print_enable) Q_next = S_UART_WAIT;
      else Q_next = S_UART_IDLE;
    S_UART_WAIT: // wait for the transmission of current data byte begins
      if (is_transmitting == 1) Q_next = S_UART_SEND;
      else Q_next = S_UART_WAIT;
    S_UART_SEND: // wait for the transmission of current data byte finishes
      if (is_transmitting == 0) Q_next = S_UART_INCR; // transmit next character
      else Q_next = S_UART_SEND;
    S_UART_INCR:
      if (tx_byte == 8'h0) Q_next = S_UART_IDLE; // string transmission ends
      else Q_next = S_UART_WAIT;
  endcase
end

// FSM output logics
assign transmit = (Q_next == S_UART_WAIT || print_enable);
assign tx_byte = data[send_counter];

// UART send_counter control circuit
always @(posedge clk) begin
  case (P_next)
    S_MAIN_INIT: send_counter <= PROMPT_STR;
    S_MAIN_WAIT_KEY: send_counter <= HELLO_STR;
    default: send_counter <= send_counter + (Q_next == S_UART_INCR);
  endcase
end
// End of the FSM of the print string controller


endmodule
