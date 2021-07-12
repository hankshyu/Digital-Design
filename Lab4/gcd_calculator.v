`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/07/09 22:46:30
// Design Name:
// Module Name: gcd_calculator
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


module gcd_calculator(input clk,
                      input rst_n,
                      input enable,
                      input [15:0] A,
                      input [15:0] B,
                      output [15:0] answer,
                      output answer_available);
    
    reg [15:0] A_store;
    reg [15:0] B_store;
    reg reg_answer_available;
    
    localparam [2:0] S_INIT      = 0;
    localparam [2:0] S_JUDGE     = 1;
    localparam [2:0] S_A_GREATER = 2;
    localparam [2:0] S_A_SMALLER = 3;
    localparam [2:0] S_EQUAL     = 4;

    reg [2:0] current_state, next_state;
    
    always @(posedge clk ,negedge rst_n) begin
        if (!rst_n) current_state <= S_INIT;
        else current_state        <= next_state;
    end
    
    always @(*) begin
        case(current_state)
            S_INIT: next_state = (enable)?S_JUDGE:S_INIT;
            S_JUDGE:begin
                if (A_store > B_store) next_state       = S_A_GREATER;
                else if (A_store < B_store) next_state  = S_A_SMALLER;
                else if (A_store == B_store) next_state = S_EQUAL;
            end
            S_A_GREATER:next_state = S_JUDGE;
            S_A_SMALLER:next_state = S_JUDGE;
            S_EQUAL:next_state     = S_EQUAL;
            default:next_state     = S_INIT;
        endcase
    end
    
    always @(posedge clk) begin
        if (!rst_n)A_store <= 0;
        else if (current_state == S_INIT)A_store <= A;
        else if (current_state == S_A_GREATER) A_store <= A_store-B_store;
    end
    
    always @(posedge clk) begin
        if (!rst_n)B_store <= 0;
        else if (current_state == S_INIT) B_store <= B;
        else if (current_state == S_A_SMALLER) B_store <= B_store-A_store;
    end
    
    always @(posedge clk) begin
        if(!rst_n) reg_answer_available<=0;
        else if (current_state == S_JUDGE && next_state == S_EQUAL) reg_answer_available       <= 1;
        //else reg_answer_available = 0;
    end
    

    //output logic
    assign answer_available = reg_answer_available;
    assign answer           = A_store;
    
endmodule
