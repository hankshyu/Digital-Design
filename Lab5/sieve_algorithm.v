`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/07/13 18:50:54
// Design Name:
// Module Name: sieve_algorithm
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


module sieve_algorithm(input clk,
                       input rst,
                       output [1719:0] primes,
                       output answer_available);
    
    parameter UPPER_BOUND      = 1023 ;
    parameter HALF_UPPER_BOUND = 511;
    parameter WORD_WIDTH       = 10;
    
    localparam S_INIT           = 0;
    localparam S_PRE_SEIVE      = 1;
    localparam S_PRE_SEIVE_WAIT = 5;
    localparam S_SEIVE          = 2;
    localparam S_COLLECT        = 3;
    localparam S_DONE           = 4;
    reg[2:0] current_state, next_state;
    
    
    
    reg [10:0] in_counter;
    reg [10:0] out_counter;
    reg [1023:0] candidates;
    reg [1719:0] reg_prime_out;
    reg[10:0] i,j;
    
    always @(posedge clk) begin
        if (rst)current_state <= S_INIT;
        else current_state    <= next_state;
    end
    
    always @(*) begin
        case(current_state)
            S_INIT:next_state = S_PRE_SEIVE;
            S_PRE_SEIVE:begin
                if (sieve_done) next_state                            = S_COLLECT;
                else if (candidates[i]&&(i+i)<UPPER_BOUND) next_state = S_SEIVE;
                else next_state                                       = S_PRE_SEIVE;
            end
            
            S_SEIVE: next_state = (j+i>UPPER_BOUND)?S_PRE_SEIVE:S_SEIVE;
            
            S_COLLECT:next_state = (collect_done)?S_DONE:S_COLLECT;
            S_DONE:next_state    = S_DONE;
            default:next_state   = S_INIT;
        endcase
    end
    
    
    assign sieve_done   = (i == 512);
    assign collect_done = (in_counter >= 1023);
    
    
    always @(posedge clk) begin
        if (current_state == S_INIT) i <= 1;
        else if (current_state == S_PRE_SEIVE) i <= i+1;
    end
    
    always @(posedge clk) begin
        if (current_state == S_INIT) j <= 0;
        else if (current_state == S_PRE_SEIVE) j <= i+i;
        else if (current_state == S_SEIVE) j <= j+i-1;
        else j <= 0;
    end
    
    always@(posedge clk)begin
        if (current_state == S_INIT) candidates <= {{1022{1'b1}},2'b00};
        else if (current_state == S_SEIVE)begin
        if (j<UPPER_BOUND)candidates[j] = 0;
    end
    end
    
    
    assign found_prime = (candidates[in_counter]);
    
    always @(posedge clk) begin
        if (current_state == S_INIT)in_counter <= 0;
        else if (current_state == S_COLLECT) in_counter <= in_counter+1;
    end
    
    always @(posedge clk) begin
        if (current_state == S_INIT)out_counter <= 0;
        else if (current_state == S_COLLECT && found_prime)out_counter <= out_counter+WORD_WIDTH;
    end
    
    always @(posedge clk) begin
        if (current_state == S_INIT)reg_prime_out <= {1720{1'd0}};
        else if (current_state == S_COLLECT && found_prime) reg_prime_out[out_counter +:10]<= in_counter;
    end
    
    
    
    assign primes = reg_prime_out;
    
    assign answer_available = (current_state == S_DONE);
    
endmodule
