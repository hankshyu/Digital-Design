`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of CS, National Chiao Tung University
// Engineer: Chun-Jen Tsai
//
// Create Date: 2017/10/16 14:21:33
// Design Name:
// Module Name: lab5
// Project Name:
// Target Devices: Xilinx FPGA @ 100MHz
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

module lab5(input clk,
            input reset_n,
            input [3:0] usr_btn,
            output [3:0] usr_led,
            output LCD_RS,
            output LCD_RW,
            output LCD_E,
            output [3:0] LCD_D);
    
    // turn off all the LEDs
    assign usr_led = 4'b0000;
    
    reg [2:0] current_state, next_state;
    localparam [2:0]S_INIT            = 0;
    localparam [2:0]S_CALCULATE_PRIME = 1;
    localparam [2:0]S_DISPLAY_UP      = 2;
    localparam [2:0]S_DISPLAY_DOWN    = 3;
    localparam [2:0]S_UP_TO_DOWN      = 4;
    localparam [2:0]S_DOWN_TO_UP      = 5;
    
    parameter DISPLAY_DELAY = 70_000_000;
    reg [$clog2(DISPLAY_DELAY):0] display_delay_counter;
    
    wire btn_level;
    reg prev_btn_level;
    wire btn_pressed;
    
    reg [127:0] row_A;
    reg [127:0] row_B;
    reg [9:0] A_pointer;
    reg [9:0] A_pointer_next;
    reg [9:0] B_pointer;
    reg [9:0] B_pointer_next;
    reg [7:0] A_number;
    reg [7:0] B_number;
    
    
    wire prime_answer_available;
    
    reg prime_collect_enable;
    wire prime_available;
 

    reg [1719:0] reg_prime;
    wire [1719:0] prime_collect_out;
    
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
    
    sieve_algorithm sieve_algorithm(
    .clk(clk),
    .rst(~reset_n),
    .primes(prime_collect_out),
    .answer_available(prime_answer_available)
    );


    always @(*) reg_prime = prime_collect_out;
    
    always @(posedge clk) begin
        if (~reset_n)
            prev_btn_level <= 1;
        else
            prev_btn_level <= btn_level;
    end
    
    assign btn_pressed = (btn_level == 1 && prev_btn_level == 0);

    wire [10:0]reg_prime_index_A,reg_prime_index_B;
    assign reg_prime_index_A=10*(A_number-1);
    assign reg_prime_index_B=10*(B_number-1);
   
    always @(posedge clk) begin
        row_A <= {"Prime #",binaryToAscii(.binary(A_number[7:4])),binaryToAscii(.binary(A_number[3:0]))," is "
        ,binaryToAscii(.binary(reg_prime[reg_prime_index_A+8 +:2])),binaryToAscii(.binary(reg_prime[reg_prime_index_A+4 +:4])),
        binaryToAscii(.binary(reg_prime[reg_prime_index_A +:4]))};
    end

    always @(posedge clk) begin
        row_B <= {"Prime #",binaryToAscii(.binary(B_number[7:4])),binaryToAscii(.binary(B_number[3:0]))," is "
        ,binaryToAscii(.binary(reg_prime[reg_prime_index_B+8 +:2])),binaryToAscii(.binary(reg_prime[reg_prime_index_B+4 +:4])),
        binaryToAscii(.binary(reg_prime[reg_prime_index_B +:4]))};
    end
    
    always @(posedge clk) begin
        if (!reset_n)current_state <= S_INIT;
        else current_state         <= next_state;
    end
    
    always @(*) begin
        case(current_state)
            S_INIT:next_state = S_CALCULATE_PRIME;
            
            S_CALCULATE_PRIME:next_state = (prime_answer_available)?S_DISPLAY_UP:S_CALCULATE_PRIME;
            
            S_DISPLAY_UP:next_state      = (btn_pressed)?S_UP_TO_DOWN:S_DISPLAY_UP;
            S_UP_TO_DOWN:next_state      = S_DISPLAY_DOWN;
            S_DISPLAY_DOWN:next_state    = (btn_pressed)?S_DOWN_TO_UP:S_DISPLAY_DOWN;
            S_DOWN_TO_UP:next_state      = S_DISPLAY_UP;
            default:next_state           = S_INIT;
        endcase
        
    end

    always @(posedge clk) begin
        if (current_state == S_DISPLAY_UP || current_state == S_DISPLAY_DOWN)
            display_delay_counter      <= (display_delay_counter>DISPLAY_DELAY)? 0 :display_delay_counter+1;
        else display_delay_counter <= 0;
        
    end
    wire display_delay_counter_expire;
    assign display_delay_counter_expire = (display_delay_counter == DISPLAY_DELAY);
    
    always@(posedge clk) begin
        if (current_state == S_CALCULATE_PRIME) A_number <= 1;
        else if (display_delay_counter_expire && current_state == S_DISPLAY_UP) A_number <= B_number;
        else if (display_delay_counter_expire && current_state == S_DISPLAY_DOWN) A_number <= (A_number == 1)?8'hAC:A_number-1;

    end
    
    always@(posedge clk) begin
        if (current_state == S_CALCULATE_PRIME) B_number <= 3;
        else if (display_delay_counter_expire && current_state == S_DISPLAY_UP) B_number <= (B_number == 8'hAC)?1:B_number+1;
        else if (display_delay_counter_expire && current_state == S_DISPLAY_DOWN) B_number <= A_number;

    end

    function [7:0] binaryToAscii;
        input [7:0] binary;

        binaryToAscii=(binary>=10)?binary-10+"A":binary+"0";
        
    endfunction
  
endmodule
    
