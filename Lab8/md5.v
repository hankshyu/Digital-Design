`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/07/19 21:05:52
// Design Name:
// Module Name: md5
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

module md5 (input clk,
            input reset_n,
            input [63:0] pwd,
            output [127:0] hash,
            output done);
    
    function [31:0] LeftRotate;
        input [31:0]x;
        input [4:0]c;
        LeftRotate = (((x) << (c)) | ((x) >> (32'd32 - (c))));
    endfunction
    
    reg [31:0] r [63:0];
    reg [31:0] k [63:0];
    wire [31:0] w [15:0];
    
    reg [31:0] h0 = 32'h67452301;
    reg [31:0] h1 = 32'hefcdab89;
    reg [31:0] h2 = 32'h98badcfe;
    reg [31:0] h3 = 32'h10325476;
    reg [31:0] a;
    reg [31:0] b;
    reg [31:0] c;
    reg [31:0] d;
    wire [31:0] h0_a;
    wire [31:0] h1_b;
    wire [31:0] h2_c;
    wire [31:0] h3_d;
    
    reg [31:0] f;
    reg [8:0] g;
    wire[31:0] k_show;
    wire [31:0] w_show;
    wire [31:0] r_show;
    
    reg [7:0] msg [63:0];
    
    
    parameter PAD_LEN = 56;
    
    localparam S_IDLE = 0;
    localparam S_LOOP = 1;
    localparam S_DONE = 2;
    reg [1:0]current_state, next_state;
    
    reg[6:0]loop_idx;
    
    
    //initialize r,k
    initial begin
        {
        r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15],
        r[16], r[17], r[18], r[19], r[20], r[21], r[22], r[23], r[24], r[25], r[26], r[27], r[28], r[29], r[30], r[31],
        r[32], r[33], r[34], r[35], r[36], r[37], r[38], r[39], r[40], r[41], r[42], r[43], r[44], r[45], r[46], r[47],
        r[48], r[49], r[50], r[51], r[52], r[53], r[54], r[55], r[56], r[57], r[58], r[59], r[60], r[61], r[62], r[63]
        }
 <= {
        32'd7, 32'd12, 32'd17, 32'd22, 32'd7, 32'd12, 32'd17, 32'd22, 32'd7, 32'd12, 32'd17, 32'd22, 32'd7, 32'd12, 32'd17, 32'd22,
        32'd5, 32'd9, 32'd14, 32'd20, 32'd5,  32'd9, 32'd14, 32'd20, 32'd5,  32'd9, 32'd14, 32'd20, 32'd5, 32'd9, 32'd14, 32'd20,
        32'd4, 32'd11, 32'd16, 32'd23, 32'd4, 32'd11, 32'd16, 32'd23, 32'd4, 32'd11, 32'd16, 32'd23, 32'd4, 32'd11, 32'd16, 32'd23,
        32'd6, 32'd10, 32'd15, 32'd21, 32'd6, 32'd10, 32'd15, 32'd21, 32'd6, 32'd10, 32'd15, 32'd21, 32'd6, 32'd10, 32'd15, 32'd21
        };
    end
    
    initial begin
        {
        k[0], k[1], k[2], k[3], k[4], k[5], k[6], k[7], k[8], k[9], k[10], k[11], k[12], k[13], k[14], k[15],
        k[16], k[17], k[18], k[19], k[20], k[21], k[22], k[23], k[24], k[25], k[26], k[27], k[28], k[29], k[30], k[31],
        k[32], k[33], k[34], k[35], k[36], k[37], k[38], k[39], k[40], k[41], k[42], k[43], k[44], k[45], k[46], k[47],
        k[48], k[49], k[50], k[51], k[52], k[53], k[54], k[55], k[56], k[57], k[58], k[59], k[60], k[61], k[62], k[63]
        
        }
 <= {
        32'hd76aa478, 32'he8c7b756, 32'h242070db, 32'hc1bdceee, 32'hf57c0faf, 32'h4787c62a, 32'ha8304613, 32'hfd469501,
        32'h698098d8, 32'h8b44f7af, 32'hffff5bb1, 32'h895cd7be, 32'h6b901122, 32'hfd987193, 32'ha679438e, 32'h49b40821,
        32'hf61e2562, 32'hc040b340, 32'h265e5a51, 32'he9b6c7aa, 32'hd62f105d, 32'h02441453, 32'hd8a1e681, 32'he7d3fbc8,
        32'h21e1cde6, 32'hc33707d6, 32'hf4d50d87, 32'h455a14ed, 32'ha9e3e905, 32'hfcefa3f8, 32'h676f02d9, 32'h8d2a4c8a,
        32'hfffa3942, 32'h8771f681, 32'h6d9d6122, 32'hfde5380c, 32'ha4beea44, 32'h4bdecfa9, 32'hf6bb4b60, 32'hbebfbc70,
        32'h289b7ec6, 32'heaa127fa, 32'hd4ef3085, 32'h04881d05, 32'hd9d4d039, 32'he6db99e5, 32'h1fa27cf8, 32'hc4ac5665,
        32'hf4292244, 32'h432aff97, 32'hab9423a7, 32'hfc93a039, 32'h655b59c3, 32'h8f0ccc92, 32'hffeff47d, 32'h85845dd1,
        32'h6fa87e4f, 32'hfe2ce6e0, 32'ha3014314, 32'h4e0811a1, 32'hf7537e82, 32'hbd3af235, 32'h2ad7d2bb, 32'heb86d391
        };
    end
    
    //initialize msg to 0
    initial begin
        {
        msg[0], msg[1], msg[2], msg[3], msg[4], msg[5], msg[6], msg[7], msg[8], msg[9], msg[10], msg[11], msg[12], msg[13], msg[14], msg[15],
        msg[16], msg[17], msg[18], msg[19], msg[20], msg[21], msg[22], msg[23], msg[24], msg[25], msg[26], msg[27], msg[28], msg[29], msg[30], msg[31],
        msg[32], msg[33], msg[34], msg[35], msg[36], msg[37], msg[38], msg[39], msg[40], msg[41], msg[42], msg[43], msg[44], msg[45], msg[46], msg[47],
        msg[48], msg[49], msg[50], msg[51], msg[52], msg[53], msg[54], msg[55], msg[56], msg[57], msg[58], msg[59], msg[60], msg[61], msg[62], msg[63]
        
        }
 <= {
        8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,
        8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,
        8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,
        8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0
        };
    end
    
    assign {w[0],w[1],w[2],w[3],w[4],w[5],w[6],w[7],w[8],w[9],w[10],w[11],w[12],w[13],w[14],w[15]}
    = {
    {msg[3],msg[2],msg[1],msg[0]},
    {msg[7],msg[6],msg[5],msg[4]},
    {msg[11],msg[10],msg[9],msg[8]},
    {msg[15],msg[14],msg[13],msg[12]},
    {msg[19],msg[18],msg[17],msg[16]},
    {msg[23],msg[22],msg[21],msg[20]},
    {msg[27],msg[26],msg[25],msg[24]},
    {msg[31],msg[30],msg[29],msg[28]},
    {msg[35],msg[34],msg[33],msg[32]},
    {msg[39],msg[38],msg[37],msg[36]},
    {msg[43],msg[42],msg[41],msg[40]},
    {msg[47],msg[46],msg[45],msg[44]},
    {msg[51],msg[50],msg[49],msg[48]},
    {msg[55],msg[54],msg[53],msg[52]},
    {msg[59],msg[58],msg[57],msg[56]},
    {msg[63],msg[62],msg[61],msg[60]}
    };
    
    always @(posedge clk) begin
        if (current_state == S_IDLE)begin
            msg[7]       <= pwd[ 0+:8]+"0";
            msg[6]       <= pwd[ 8+:8]+"0";
            msg[5]       <= pwd[16+:8]+"0";
            msg[4]       <= pwd[24+:8]+"0";
            msg[3]       <= pwd[32+:8]+"0";
            msg[2]       <= pwd[40+:8]+"0";
            msg[1]       <= pwd[48+:8]+"0";
            msg[0]       <= pwd[56+:8]+"0";
            msg[8]       <= 8'h80;
            msg[PAD_LEN] <= 8'd64;
            
        end
    end
    
    always @(posedge clk) begin
        if (!reset_n)current_state <= S_IDLE;
        else current_state         <= next_state;
    end
    
    always @(*) begin
        case(current_state)
            S_IDLE:next_state = S_LOOP;
            S_LOOP:next_state = (loop_idx == 63)?S_DONE:S_LOOP;
            S_DONE:next_state = S_DONE;
            default next_state =S_IDLE;
            
        endcase
    end
    
    always @(posedge clk) begin
        if (current_state == S_IDLE) loop_idx      <= 0;
        else if (current_state == S_LOOP) loop_idx <= loop_idx+1;
    end
    
    always @(*) begin
        if (current_state == S_IDLE)f = 0;
        else if (current_state == S_LOOP)begin
        if (loop_idx< 16)f         = (b & c) | ((~b) & d);
        else if (loop_idx<32)f     = (d & b) | ((~d) & c);
        else if (loop_idx<48)f = b ^ c ^ d;
        else f                 = c ^ (b | (~d));
            end
        else f = 0;
    end
        
    always @(*) begin
        if (current_state == S_IDLE) g = 0;
        else if (current_state == S_LOOP)begin
            if (loop_idx< 16)g = loop_idx;
            else if (loop_idx<32)g = (5*loop_idx + 1) % 16;
            else if (loop_idx<48)g = (3*loop_idx + 5) % 16;
            else g                 = (7*loop_idx) % 16;
        end
        else g = 0;
    end
    always @(posedge clk) begin
        if (current_state == S_IDLE)begin
            a <= h0;
            b <= h1;
            c <= h2;
            d <= h3;
        end
        else if (current_state == S_LOOP)begin
            a <= d;
            d <= c;
            c <= b;
            b <= b+LeftRotate(.x(a+f+k_show+w_show),.c(r_show));
        end        
    end
            
    assign k_show = k[loop_idx%64];
    assign w_show = w[g%64];
    assign r_show = r[loop_idx%64];
        
    assign h0_a = h0+a;
    assign h1_b = h1+b;
    assign h2_c = h2+c;
    assign h3_d = h3+d;
    
    assign hash = {
    h0_a[7:0],h0_a[15:8],h0_a[23:16],h0_a[31:24],
    h1_b[0+:8],h1_b[8+:8],h1_b[16+:8],h1_b[24+:8],
    h2_c[0+:8],h2_c[8+:8],h2_c[16+:8],h2_c[24+:8],
    h3_d[0+:8],h3_d[8+:8],h3_d[16+:8],h3_d[24+:8]
    };
    
    assign done = (current_state == S_DONE);
    
endmodule

//------------------------------
