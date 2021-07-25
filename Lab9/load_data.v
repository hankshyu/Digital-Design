`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/07/24 15:08:05
// Design Name:
// Module Name: load_data
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


module load_data(input clk,
                 input rst_n,
                 input [3:0] usr_btn,
                 output signed[21:0] maxproduct_out,
                 output [$clog2(960):0] maxproductlocation_out, output done);
    
    
    reg signed[21:0] maxproduct;
    reg [$clog2(960):0] maxproductlocation;
    reg signed [21:0] productfg;
    reg signed [7:0] reg_f [63:0];
    reg signed [7:0] reg_g [63:0];
    
    
    reg [$clog2(64):0] g_counter;
    reg [$clog2(64):0] f_counter;
    reg [$clog2(1024):0] shift_counter;
    reg [$clog2(64):0] add_counter;
    
    localparam S_IDLE       = 0;
    localparam S_LOAD_G     = 1;
    localparam S_DONE_G     = 2;
    localparam S_LOAD_F     = 3;
    localparam S_DONE_F     = 4;
    localparam S_SHIFT_ADDR = 5;
    localparam S_SHIFT      = 6;
    localparam S_ADD        = 7;
    localparam S_COMP       = 8;
    localparam S_DONE       = 9;
    reg [3:0] current_state, next_state;
    
    //sram related variable
    reg  [11:0] sample_addr;
    wire [10:0] sram_addr;
    wire [7:0]  data_in;
    wire [7:0]  data_out;
    wire        sram_we, sram_en;
    
    sram sram(
    .clk(clk),
    .we(sram_we),
    .en(sram_en),
    .addr(sram_addr),
    .data_i(data_in),
    .data_o(data_out)
    );
    
    assign sram_we   = usr_btn[3];
    assign sram_addr = sample_addr;
    assign sram_en   = (current_state == S_LOAD_G || current_state == S_LOAD_F);
    assign data_in   = 0;
    
    assign g_state_ok     = (g_counter == 64);
    assign f_state_ok     = (f_counter == 64);
    assign add_ok         = (add_counter == 63);
    assign shift_state_ok = (shift_counter == 1024);
    
    always @(posedge clk) begin
        if (!rst_n)current_state <= S_IDLE;
        else current_state       <= next_state;
    end
    
    always @(*) begin
        case(current_state)
            S_IDLE:next_state = S_LOAD_G;
            
            S_LOAD_G:next_state = (g_state_ok)?S_DONE_G:S_LOAD_G;
            
            S_DONE_G:next_state = S_LOAD_F;
            
            S_LOAD_F:next_state = (f_state_ok)?S_DONE_F:S_LOAD_F;
            
            S_DONE_F:next_state = S_SHIFT_ADDR;
            
            S_SHIFT_ADDR:next_state = S_SHIFT;
            
            S_SHIFT:next_state = S_ADD;
            
            S_ADD:next_state = (add_ok)?S_COMP:S_ADD;
            
            S_COMP:next_state = (shift_state_ok)?S_DONE:S_SHIFT_ADDR;
            
            S_DONE:next_state = S_DONE;
            
            default: next_state = S_IDLE;
            
        endcase
    end
    
    always @(posedge clk) begin
        if (current_state == S_IDLE) g_counter <= 0;
        else if (current_state == S_LOAD_G) g_counter <= g_counter+1;
    end
    
    always @(posedge clk) begin
        if (current_state == S_IDLE) f_counter <= 0;
        else if (current_state == S_LOAD_F) f_counter <= f_counter+1;
    end
    
    always @(posedge clk) begin
        if (current_state == S_IDLE)shift_counter<= 64;
        else if (current_state == S_COMP) shift_counter <= shift_counter+1;
    end
    
    always @(posedge clk) begin
        if (current_state == S_SHIFT) add_counter <= 0;
        else if (current_state == S_ADD) add_counter <= add_counter+1;
    end
    
    always @(posedge clk) begin
        if (current_state == S_IDLE) sample_addr <= 1024;
        else if (current_state == S_DONE_G)sample_addr <= 0;
        else if (current_state == S_DONE_F)sample_addr <= 64;
        else if (current_state == S_LOAD_G || current_state == S_LOAD_F) sample_addr <= sample_addr+1;
        else if (current_state == S_SHIFT_ADDR) sample_addr <= shift_counter;
    end
    
    always @(posedge clk) begin
        if (current_state == S_SHIFT) productfg<= 0;
        else if (current_state == S_ADD) productfg <= productfg+(reg_f[add_counter] * reg_g[add_counter]);
    end
    
    always @(posedge clk) begin
        if (current_state == S_IDLE)begin
            maxproduct         <= 0;
            maxproductlocation <= 0;
            
        end
        else if (current_state == S_COMP)begin
            if (shift_counter == 64 || productfg > maxproduct)begin
                maxproduct         <= productfg;
                maxproductlocation <= shift_counter-64;
            end
        end
            
    end
              
    reg [6:0] m;
    always @(posedge clk) begin
        if (current_state == S_IDLE)begin
            for(m = 0; m<64; m = m+1)begin
                reg_g[m] <= 0;
            end
        end
        else if (current_state == S_LOAD_G && g_counter != 0)begin
            reg_g[g_counter-1] <= data_out;
        end
    end
    reg [6:0] n,q;
    
    always @(posedge clk) begin
        if (current_state == S_IDLE)begin
            for(n = 0; n<64; n = n+1)begin
                reg_f[n] <= 0;
            end
        end
        else if (current_state == S_LOAD_F && f_counter != 0)begin
            reg_f[f_counter-1] <= data_out;
        end
        else if (current_state == S_SHIFT)begin
            for(q = 1; q<64; q = q+1)begin
                reg_f[q-1] <= reg_f[q];
            end
            reg_f[63] <= data_out;
        end
    end
                            
    //output
    
    assign done                   = (current_state == S_DONE);
    assign maxproduct_out         = maxproduct;
    assign maxproductlocation_out = maxproductlocation;
    
endmodule
                            
