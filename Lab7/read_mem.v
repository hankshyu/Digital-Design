`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/29 16:57:08
// Design Name: 
// Module Name: read_mem
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

module read_mem(
    input clk,
    input rst_n,
    input [3:0] btn,
    output reg [127:0] A,
    output reg [127:0] B,
    output done);

    localparam S_INIT = 0;
    localparam S_READ_A = 1;
    localparam S_DONE_A = 2;
    localparam S_READ_B = 3;
    localparam S_DONE_B = 4;
    reg [2:0] current_state, next_state;

    reg [4:0] A_counter;
    reg [5:0] B_counter;
    wire a_done;
    wire b_done;

    //ram variables
    reg [5:0] ram_addr;
    wire [7:0] ram_data_o;

    sram #(.DATA_WIDTH(8),.ADDR_WIDTH(6),.RAM_SIZE(32))ram(
        .clk(clk),
        .we(btn[3]),
        .en(1),
        .addr(ram_addr),
        .data_i(0),
        .data_o(ram_data_o)
    );

    assign a_done = (A_counter == 17);
    assign b_done = (B_counter == 34);

    always @(posedge clk ) begin
        if(!rst_n)current_state <= S_INIT;
        else current_state <= next_state;
    end

    always @(*) begin
        case(current_state)
        S_INIT:next_state = S_READ_A;

        S_READ_A:next_state = (a_done)?S_DONE_A:S_READ_A;

        S_DONE_A:next_state = S_READ_B;

        S_READ_B:next_state = (b_done)?S_DONE_B:S_READ_B;

        S_DONE_B:next_state = S_DONE_B;
        default:next_state = S_INIT;
        endcase 
    end

    always @(posedge clk ) begin
        if(current_state == S_READ_A)
            A_counter <= A_counter + 1;
        else 
            A_counter <= 0;
    end

    always @(posedge clk ) begin
        if(current_state == S_READ_B)
            B_counter <= B_counter + 1;
        else 
            B_counter <= 16;
    end

    always @(posedge clk ) begin
        if(current_state == S_INIT || current_state == S_DONE_A)
            ram_addr <= 0;
        else if(current_state == S_READ_A)
            ram_addr <= A_counter;
        else if(current_state == S_READ_B)
            ram_addr <= B_counter;
        
    end
    //output logic

    always @(posedge clk ) begin
        if(current_state == S_INIT)
            A <= 0;
        else if(current_state == S_READ_A && A_counter >= 2)
            A[(A_counter-2)*8 +: 8] <= ram_data_o;
    end

    always @(posedge clk ) begin
        if(current_state == S_INIT)
            B <= 0;
        else if(current_state == S_READ_B && B_counter >= 18)
            B[(B_counter - 18)*8 +: 8] <= ram_data_o;
    end

    assign done = (current_state == S_DONE_B);

endmodule
