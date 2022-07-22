`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/22 11:20:15
// Design Name: 
// Module Name: crack_top
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


module crack_top(
    input clk,
    input rst_n,
    output reg [31:0] answer,
    output done);

    reg [127:0] cp_hash_answer = 128'hE9982EC5CA981BD365603623CF4B2277;
    parameter NUM_OF_DECODER = 32;

    reg [31:0] cp_lower_bound [NUM_OF_DECODER-1:0];
    reg [31:0] cp_upper_bound [NUM_OF_DECODER-1:0];
    wire [31:0] cp_answer [NUM_OF_DECODER-1:0];
    wire[NUM_OF_DECODER-1:0] cp_answer_found;
    wire [NUM_OF_DECODER-1:0] cp_done ;
    
    //     initial begin
    //     {
    //         cp_lower_bound[0],cp_lower_bound[1],cp_lower_bound[2],cp_lower_bound[3],cp_lower_bound[4],
    //         cp_lower_bound[5],cp_lower_bound[6],cp_lower_bound[7],cp_lower_bound[8],cp_lower_bound[9]
    //     }<=
    //     {
    //         32'h0000_0000,32'h1000_0000,32'h2000_0000,32'h3000_0000,32'h4000_0000,
    //         32'h5000_0000,32'h6000_0000,32'h7000_0000,32'h8000_0000,32'h9000_0000

    //     };
    // end

    // initial begin
    //     {
    //         cp_upper_bound[0],cp_upper_bound[1],cp_upper_bound[2],cp_upper_bound[3],cp_upper_bound[4],
    //         cp_upper_bound[5],cp_upper_bound[6],cp_upper_bound[7],cp_upper_bound[8],cp_upper_bound[9]
    //     }<=
    //     {
    //         32'h0999_9999,32'h1999_9999,32'h2999_9999,32'h3999_9999,32'h4999_9999,
    //         32'h5999_9999,32'h6999_9999,32'h7999_9999,32'h8999_9999,32'h9999_9999
    //     };
    // end






      initial begin
        {
            cp_lower_bound[ 0],cp_lower_bound[ 1],cp_lower_bound[ 2],cp_lower_bound[ 3],cp_lower_bound[ 4],cp_lower_bound[ 5],cp_lower_bound[ 6],cp_lower_bound[ 7],
            cp_lower_bound[ 8],cp_lower_bound[ 9],cp_lower_bound[10],cp_lower_bound[11],cp_lower_bound[12],cp_lower_bound[13],cp_lower_bound[15],cp_lower_bound[15],
            cp_lower_bound[16],cp_lower_bound[17],cp_lower_bound[18],cp_lower_bound[19],cp_lower_bound[20],cp_lower_bound[21],cp_lower_bound[22],cp_lower_bound[23],
            cp_lower_bound[24],cp_lower_bound[25],cp_lower_bound[26],cp_lower_bound[27],cp_lower_bound[28],cp_lower_bound[29],cp_lower_bound[30],cp_lower_bound[31]
        }<=
        {
            32'h0000_0000,32'h0312_0000,32'h0625_0000,32'h0937_0000,32'h1250_0000,32'h1562_0000,32'h1875_0000,32'h2187_0000,
            32'h2500_0000,32'h2812_0000,32'h3125_0000,32'h3437_0000,32'h3750_0000,32'h4062_0000,32'h4375_0000,32'h4687_0000,
            32'h5000_0000,32'h5312_0000,32'h5625_0000,32'h5937_0000,32'h6250_0000,32'h6562_0000,32'h6875_0000,32'h7187_0000,
            32'h7500_0000,32'h7812_0000,32'h8125_0000,32'h8437_0000,32'h8750_0000,32'h9062_0000,32'h9375_0000,32'h9687_0000
            

        };
    end

    initial begin
    {
        cp_upper_bound[ 0],cp_upper_bound[ 1],cp_upper_bound[ 2],cp_upper_bound[ 3],cp_upper_bound[ 4],cp_upper_bound[ 5],cp_upper_bound[ 6],cp_upper_bound[ 7],
        cp_upper_bound[ 8],cp_upper_bound[ 9],cp_upper_bound[10],cp_upper_bound[11],cp_upper_bound[12],cp_upper_bound[13],cp_upper_bound[15],cp_upper_bound[15],
        cp_upper_bound[16],cp_upper_bound[17],cp_upper_bound[18],cp_upper_bound[19],cp_upper_bound[20],cp_upper_bound[21],cp_upper_bound[22],cp_upper_bound[23],
        cp_upper_bound[24],cp_upper_bound[25],cp_upper_bound[26],cp_upper_bound[27],cp_upper_bound[28],cp_upper_bound[29],cp_upper_bound[30],cp_upper_bound[31]
    }<=
    {
        32'h0311_9999,32'h0624_9999,32'h0936_9999,32'h1249_9999,32'h1561_9999,32'h1874_9999,32'h2186_9999,32'h2499_9999,
        32'h2811_9999,32'h3124_9999,32'h3436_9999,32'h3749_9999,32'h4061_9999,32'h4374_9999,32'h4686_9999,32'h4999_9999,
        32'h5311_9999,32'h5624_9999,32'h5936_9999,32'h6249_9999,32'h6561_9999,32'h6874_9999,32'h7186_9999,32'h7499_9999,
        32'h7811_9999,32'h8124_9999,32'h8436_9999,32'h8749_9999,32'h9061_9999,32'h9374_9999,32'h9686_9999,32'h9999_9999
        

    };
    end

//     initial begin
//         {
//             cp_lower_bound[ 0],cp_lower_bound[ 1],cp_lower_bound[ 2],cp_lower_bound[ 3],cp_lower_bound[ 4],cp_lower_bound[ 5],cp_lower_bound[ 6],cp_lower_bound[ 7],
//             cp_lower_bound[ 8],cp_lower_bound[ 9],cp_lower_bound[10],cp_lower_bound[11],cp_lower_bound[12],cp_lower_bound[13],cp_lower_bound[15],cp_lower_bound[15],
//             cp_lower_bound[16],cp_lower_bound[17],cp_lower_bound[18],cp_lower_bound[19],cp_lower_bound[20],cp_lower_bound[21],cp_lower_bound[22],cp_lower_bound[23],
//             cp_lower_bound[24]
//         }<=
//         {
//         32'h0000_0000,32'h0400_0000,32'h0800_0000,32'h1200_0000,32'h1600_0000,
//         32'h2000_0000,32'h2400_0000,32'h2800_0000,32'h3200_0000,32'h3600_0000,
//         32'h4000_0000,32'h4400_0000,32'h4800_0000,32'h5200_0000,32'h5600_0000,
//         32'h6000_0000,32'h6400_0000,32'h6800_0000,32'h7200_0000,32'h7600_0000,
//         32'h8000_0000,32'h8400_0000,32'h8800_0000,32'h9200_0000,32'h9600_0000
            

//         };
//     end

//     initial begin
//     {
//         cp_upper_bound[ 0],cp_upper_bound[ 1],cp_upper_bound[ 2],cp_upper_bound[ 3],cp_upper_bound[ 4],cp_upper_bound[ 5],cp_upper_bound[ 6],cp_upper_bound[ 7],
//         cp_upper_bound[ 8],cp_upper_bound[ 9],cp_upper_bound[10],cp_upper_bound[11],cp_upper_bound[12],cp_upper_bound[13],cp_upper_bound[15],cp_upper_bound[15],
//         cp_upper_bound[16],cp_upper_bound[17],cp_upper_bound[18],cp_upper_bound[19],cp_upper_bound[20],cp_upper_bound[21],cp_upper_bound[22],cp_upper_bound[23],
//         cp_upper_bound[24]
//     }<=
//     {
// 32'h0399_9999,32'h0799_9999,32'h1199_9999,32'h1599_9999,32'h1999_9999,
// 32'h2399_9999,32'h2799_9999,32'h3199_9999,32'h3599_9999,32'h3999_9999,
// 32'h4399_9999,32'h4799_9999,32'h5199_9999,32'h5599_9999,32'h5999_9999,
// 32'h6399_9999,32'h6799_9999,32'h7199_9999,32'h7599_9999,32'h7999_9999,
// 32'h8399_9999,32'h8799_9999,32'h9199_9999,32'h9599_9999,32'h9999_9999
        

//     };
//     end




    
    genvar i;
    generate
        for (i=0;i<NUM_OF_DECODER;i=i+1)begin
            crack_partial cp(
                .clk(clk),
                .rst_n(rst_n),
                .lower_bound(cp_lower_bound[i]),
                .upper_bound(cp_upper_bound[i]),
                .hash_answer(cp_hash_answer),
                .answer(cp_answer[i]),
                .answer_found(cp_answer_found[i]),
                .done(cp_done[i])
            );
        end
        
    endgenerate
    // crack_partial cp(
    //             .clk(clk),
    //             .rst_n(rst_n),
    //             .lower_bound(cp_lower_bound[0]),
    //             .upper_bound(cp_upper_bound[9]),
    //             .hash_answer(cp_hash_answer),
    //             .answer(cp_answer[0]),
    //             .answer_found(cp_answer_found[0]),
    //             .done(cp_done[0])
    //         );

    assign done = |cp_done;

    always @(*) begin
        if      (cp_answer_found[0])answer  = cp_answer[ 0];
        else if(cp_answer_found[ 1])answer  = cp_answer[ 1];
        else if(cp_answer_found[ 2])answer  = cp_answer[ 2];
        else if(cp_answer_found[ 3])answer  = cp_answer[ 3];
        else if(cp_answer_found[ 4])answer  = cp_answer[ 4];
        else if(cp_answer_found[ 5])answer  = cp_answer[ 5];
        else if(cp_answer_found[ 6])answer  = cp_answer[ 6];
        else if(cp_answer_found[ 7])answer  = cp_answer[ 7];
        else if(cp_answer_found[ 8])answer  = cp_answer[ 8];
        else if(cp_answer_found[ 9])answer  = cp_answer[ 9];
        else if(cp_answer_found[10])answer  = cp_answer[10];
        else if(cp_answer_found[11])answer  = cp_answer[11];
        else if(cp_answer_found[12])answer  = cp_answer[12];
        else if(cp_answer_found[13])answer  = cp_answer[13];
        else if(cp_answer_found[14])answer  = cp_answer[14];
        else if(cp_answer_found[15])answer  = cp_answer[15];
        else if(cp_answer_found[16])answer  = cp_answer[16];
        else if(cp_answer_found[17])answer  = cp_answer[17];
        else if(cp_answer_found[18])answer  = cp_answer[18];
        else if(cp_answer_found[19])answer  = cp_answer[19];
        else if(cp_answer_found[20])answer  = cp_answer[20];
        else if(cp_answer_found[21])answer  = cp_answer[21];
        else if(cp_answer_found[22])answer  = cp_answer[22];
        else if(cp_answer_found[23])answer  = cp_answer[23];
        else if(cp_answer_found[24])answer  = cp_answer[24];
        else if(cp_answer_found[25])answer  = cp_answer[25];
        else if(cp_answer_found[26])answer  = cp_answer[26];
        else if(cp_answer_found[27])answer  = cp_answer[27];
        else if(cp_answer_found[28])answer  = cp_answer[28];
        else if(cp_answer_found[29])answer  = cp_answer[29];
        else if(cp_answer_found[30])answer  = cp_answer[30];
        else if(cp_answer_found[31])answer  = cp_answer[31];
        else answer = 32'hffff_ffff;
    end


endmodule
