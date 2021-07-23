`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/21 22:05:48
// Design Name: 
// Module Name: crack_partial
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


module crack_partial(
    input clk,
    input rst_n,
    input [31:0]lower_bound,
    input [31:0]upper_bound,
    input [127:0]hash_answer,
    output [31:0]answer,
    output reg answer_found,
    output done);
   
    reg [31:0] i;

    //reg [0:127] hash_answer = 128'hE9982EC5CA981BD365603623CF4B2277;
    //reg [0:127] hash_answer=128'h7353b5dc1e564801ff4ddd40293b12ec;
    localparam S_IDLE = 0;
    localparam S_CHECK = 1;
    localparam S_CRACK = 2;
    localparam S_DONE = 3;
    reg [1:0] current_state, next_state;


    //md5 signals
    reg md5_rst_n;
    wire [63:0] md5_pwd;
    wire [127:0] md5_hash;
    wire md5_done;
    
    assign md5_pwd = {
        4'd0,i[28+:4],4'd0,i[24+:4],4'd0,i[20+:4],4'd0,i[16+:4],4'd0,i[12+:4],4'd0,i[8+:4],4'd0,i[4+:4],4'd0,i[0+:4]
        };

    md5 md5(
    .clk(clk),
    .reset_n(md5_rst_n),
    .pwd(md5_pwd),
    .hash(md5_hash),
    .done(md5_done)
    );

    //BCDAdder signals

    // reg [31:0] A;
    // reg [31:0] B;
    wire [31:0] BCD_Answer;

    BCDAdder BCDAdder(
     .A(i),
     .B(1),
     .Answer(BCD_Answer)
    );
    



    always @(posedge clk ) begin
        if(!rst_n)current_state<=S_IDLE;
        else current_state<=next_state;
    end

    always @(*) begin
        case(current_state)
        S_IDLE:next_state=S_CHECK;

        S_CHECK:next_state=(i>upper_bound)?S_DONE:S_CRACK;

        S_CRACK:begin
            if(md5_done && md5_hash != hash_answer) next_state = S_CHECK;
            else if(md5_done && md5_hash == hash_answer) next_state = S_DONE;
            else next_state = S_CRACK;
        end

        S_DONE:next_state= S_DONE;

        endcase
    end
    
    // always @(posedge clk ) begin
    //     if (current_state == S_CRACK && next_state ==S_CHECK)begin
    //         A<=i;

    //     end
    // end

    always @(posedge clk ) begin
        if(current_state == S_IDLE) i<=lower_bound;
        else if(current_state == S_CRACK && next_state ==S_CHECK) i<=BCD_Answer;
    end

    always @(posedge clk ) begin
        if(current_state == S_CRACK && next_state == S_CHECK)  md5_rst_n <=0;
        else if(current_state == S_IDLE && next_state == S_CHECK) md5_rst_n <= 0;
        else md5_rst_n<=1;
    end

    assign done =(current_state == S_DONE);
    assign answer = i;
    always @(posedge clk ) begin
        if(current_state == S_IDLE) answer_found <= 0;
        else if(current_state == S_CRACK && next_state == S_DONE) answer_found <= 1;
    end



endmodule
