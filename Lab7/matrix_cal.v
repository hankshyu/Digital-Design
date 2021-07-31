`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: hankshyu
// 
// Create Date: 2021/07/29 16:57:08
// Design Name: 
// Module Name: matrix_cal
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


module matrix_cal(
    input clk,
    input rst_n,
    input [3:0] btn,
    output [287:0] answer,
    output done);

    localparam [2:0] S_INIT = 0;
    localparam [2:0] S_READ_MEM = 1;
    localparam [2:0] S_OUTER_LOOP = 2;
    localparam [2:0] S_INNER_LOOP = 3;
    localparam [2:0] S_DONE = 4;
    reg [2:0] current_state, next_state;

    integer i,j;
    reg [2:0] inner_counter;
    reg [2:0] outer_counter;

    wire [4:0] A_index [3:0];
    wire [4:0] B_index [3:0];

    wire [7:0] A_index_pointing_num[3:0];
    wire [7:0] B_index_pointing_num[3:0];
    reg [15:0] multiply [3:0];
    reg [17:0] half_add_answer_1;
    reg [17:0] half_add_answer_2;
    reg [17:0] add_answer;
    
    reg [17:0] reg_answer[15:0];

    //memory realted parameters
    wire [127:0] read_mem_A;
    wire [127:0] read_mem_B;
    reg [7:0] reg_A [15:0];
    reg [7:0] reg_B [15:0];

    read_mem read_mem(
        .clk(clk),
        .rst_n(read_mem_rst_n),
        .btn(btn[3]),
        .A(read_mem_A),
        .B(read_mem_B),
        .done(read_mem_done)
    );
    assign read_mem_rst_n = (current_state!=S_INIT);
    
    always @(posedge clk ) begin
        if(!rst_n)current_state <= S_INIT;
        else current_state <= next_state;
    end

    always @(*) begin
        case(current_state)
        S_INIT:next_state=S_READ_MEM;

        S_READ_MEM:next_state = (read_mem_done)?S_OUTER_LOOP:S_READ_MEM;

        S_OUTER_LOOP:next_state=(outer_loop_end)?S_DONE:S_INNER_LOOP;

        S_INNER_LOOP:next_state=(inner_loop_end)?S_OUTER_LOOP:S_INNER_LOOP;

        S_DONE:next_state=S_DONE;
        default: next_state = S_INIT;
        endcase
    end
    genvar m;
    generate
        for(m=0;m<4;m=m+1)begin
            assign A_index_pointing_num[m] = reg_A[A_index[m]];
        end
    endgenerate

    genvar n;
    generate
        for(n=0; n<4 ;n=n+1)begin
            assign B_index_pointing_num[n] = reg_B[B_index[n]];
        end
    endgenerate


    integer k;
    always @(posedge clk ) begin
        if(current_state == S_INNER_LOOP)
            for (k = 0; k<=3; k=k+1) begin
                multiply[k] <= A_index_pointing_num[k]*B_index_pointing_num[k];
            end
    end

    always @(posedge clk ) begin
        if(current_state == S_INNER_LOOP)
            half_add_answer_1 <= multiply[0] + multiply[1];
    end

    always @(posedge clk ) begin
        if(current_state == S_INNER_LOOP)
            half_add_answer_2 <= multiply[2] + multiply[3];
    end
    
    always @(posedge clk ) begin
        if(current_state == S_INNER_LOOP)
            add_answer <= half_add_answer_1 + half_add_answer_2;
    end

    genvar g;
    generate
        for(g=0; g<4; g=g+1)begin
            assign A_index[g] = (outer_counter<<2) + g; 
        end
    endgenerate 

    genvar h;
    generate
        for(h=0; h<4 ;h=h+1)begin
            assign B_index[h] = (h<<2) + inner_counter;
        end
    endgenerate


    assign outer_loop_end = (outer_counter==4);
    assign inner_loop_end = (inner_counter==7);

    always @(posedge clk ) begin
        if(current_state == S_READ_MEM) 
            outer_counter <= 0;
        else if(current_state ==S_INNER_LOOP && next_state == S_OUTER_LOOP)
            outer_counter <= outer_counter + 1;
    end

    always @(posedge clk ) begin
        if(current_state == S_OUTER_LOOP)
            inner_counter <= 0;
        else if(current_state == S_INNER_LOOP)
            inner_counter <= inner_counter + 1;

    end

    always @(posedge clk ) begin
        if(current_state == S_INIT)
            for (i=0; i<16 ;i=i+1)begin
                reg_A[i] <= 0;
            end
        else if(current_state == S_READ_MEM)begin
            
            reg_A[ 0] <= read_mem_A[  0+:8];
            reg_A[ 1] <= read_mem_A[ 32+:8];
            reg_A[ 2] <= read_mem_A[ 64+:8];
            reg_A[ 3] <= read_mem_A[ 96+:8];
            reg_A[ 4] <= read_mem_A[  8+:8];
            reg_A[ 5] <= read_mem_A[ 40+:8];
            reg_A[ 6] <= read_mem_A[ 72+:8];
            reg_A[ 7] <= read_mem_A[104+:8];
            reg_A[ 8] <= read_mem_A[ 16+:8];
            reg_A[ 9] <= read_mem_A[ 48+:8];
            reg_A[10] <= read_mem_A[ 80+:8];
            reg_A[11] <= read_mem_A[112+:8];
            reg_A[12] <= read_mem_A[ 24+:8];
            reg_A[13] <= read_mem_A[ 56+:8];
            reg_A[14] <= read_mem_A[ 88+:8];
            reg_A[15] <= read_mem_A[120+:8];
        end

    end

    always @(posedge clk ) begin
        if(current_state == S_INIT)
            for (j=0; j<16 ;j=j+1)begin
                reg_B[j] <= 0;
            end
        else if(current_state == S_READ_MEM)begin

            reg_B[ 0] <= read_mem_B[  0+:8];
            reg_B[ 1] <= read_mem_B[ 32+:8];
            reg_B[ 2] <= read_mem_B[ 64+:8];
            reg_B[ 3] <= read_mem_B[ 96+:8];
            reg_B[ 4] <= read_mem_B[  8+:8];
            reg_B[ 5] <= read_mem_B[ 40+:8];
            reg_B[ 6] <= read_mem_B[ 72+:8];
            reg_B[ 7] <= read_mem_B[104+:8];
            reg_B[ 8] <= read_mem_B[ 16+:8];
            reg_B[ 9] <= read_mem_B[ 48+:8];
            reg_B[10] <= read_mem_B[ 80+:8];
            reg_B[11] <= read_mem_B[112+:8];
            reg_B[12] <= read_mem_B[ 24+:8];
            reg_B[13] <= read_mem_B[ 56+:8];
            reg_B[14] <= read_mem_B[ 88+:8];
            reg_B[15] <= read_mem_B[120+:8];

        end

    end
    //output logic
    wire [3:0] answer_write_idx;
    assign answer_write_idx = (outer_counter<<2) + inner_counter - 2;
    integer a;
    always @(posedge clk ) begin
        if(current_state == S_INIT)
            for(a=0;a<16;a=a+1)
                reg_answer[a] <= 0;
        else if(current_state == S_INNER_LOOP && outer_counter ==3 &&inner_counter ==6)
            reg_answer[15] <= add_answer;
        else if(current_state == S_INNER_LOOP && inner_counter >= 3 && inner_counter <= 6)
            reg_answer[answer_write_idx -1] <= add_answer;
    end

    assign done = (current_state == S_DONE);
    assign answer = 
    {
        reg_answer[15],reg_answer[14],reg_answer[13],reg_answer[12],
        reg_answer[11],reg_answer[10],reg_answer[ 9],reg_answer[ 8],
        reg_answer[ 7],reg_answer[ 6],reg_answer[ 5],reg_answer[ 4],
        reg_answer[ 3],reg_answer[ 2],reg_answer[ 1],reg_answer[ 0]
    };

endmodule
