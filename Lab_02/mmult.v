`timescale 1ns / 1ps


module mmult#(parameter MATRIX_SIZE = 3,
              parameter INPUT_UNIT_LEN = 8,
              parameter OUTPUT_UNIT_LEN = INPUT_UNIT_LEN*2+1)
             (input clk,                                      // Clock signal
              input reset_n,                                  // Reset signal (negative logic)
              input enable,                                   // Activation signal for matrix multiplication
              input [0:9*INPUT_UNIT_LEN-1] A_mat,             // A matrix
              input [0:9*INPUT_UNIT_LEN-1] B_mat,             // B matrix
              output valid,                                   // Signals that the output is valid to read
              output wire [0:9*OUTPUT_UNIT_LEN-1] C_mat);     // The result of A x B
    
    reg valid_store;
    reg [0:9*INPUT_UNIT_LEN-1] A_store,B_store;
    reg [0:9*OUTPUT_UNIT_LEN-1] C_store;
    
    reg[1:0] idx;
    reg[1:0] current_state,next_state;
    localparam S_IDLE = 0, S_ADD = 1, S_OUT = 2;
    
    integer i;
    
    //FSM
    always @(posedge clk,negedge reset_n) begin
        if (!reset_n)current_state                <= S_IDLE;
        else if (reset_n && enable) current_state <= next_state;
        else current_state                        <= S_IDLE;
        
    end
    
    wire add_done;
    assign add_done = (idx == 0);
    
    always @(*) begin
        case(current_state)
            S_IDLE: next_state = (enable)? S_ADD : S_IDLE;
            S_ADD: next_state  = (add_done)? S_OUT:S_ADD;
            S_OUT: next_state  = S_IDLE;
            default:next_state = S_IDLE;
            
        endcase
    end
    
    
    
    always @(posedge clk) begin
        if (!reset_n)idx <= 0;
        else if (enable && current_state == S_IDLE) idx <= MATRIX_SIZE-1;
        else if (enable && current_state == S_ADD) idx <= idx-1;
        else idx <= idx;
    end
    
    always @(posedge clk) begin
        if (!reset_n)A_store <= 0;
        else if (enable && current_state == S_IDLE) A_store<= A_mat;
        else A_store <= A_store;
    end
    
    always @(posedge clk) begin
        if (!reset_n)B_store <= 0;
        else if (enable && current_state == S_IDLE) B_store <= B_mat;
        else B_store <= B_store;
    end
    integer  k;
    always @(posedge clk) begin
        if (!reset_n)C_store <= 0;
        else if (enable && current_state == S_ADD) begin
        for (k = 0; k<3; k = k+1) begin
            if ((2-k) == idx)begin
                for(i = 0;i<MATRIX_SIZE;i = i+1)begin
                    C_store[OUTPUT_UNIT_LEN*(3*k+i)+:OUTPUT_UNIT_LEN] <= add_sum(
                    .a1(A_store[(3*k+0)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
                    .a2(A_store[(3*k+1)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
                    .a3(A_store[(3*k+2)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
                    .b1(B_store[INPUT_UNIT_LEN*(0+i)+:INPUT_UNIT_LEN]),
                    .b2(B_store[INPUT_UNIT_LEN*(3+i)+:INPUT_UNIT_LEN]),
                    .b3(B_store[INPUT_UNIT_LEN*(6+i)+:INPUT_UNIT_LEN])
                    );
                    
                end
                
            end
            
        end
        
        //case(idx)
        
        // 2'd2:begin
        //   for(i = 0;i<MATRIX_SIZE;i = i+1)begin
        //     C_store[OUTPUT_UNIT_LEN*(0+i)+:OUTPUT_UNIT_LEN] <= add_sum(
        //       .a1(A_store[(0+0)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .a2(A_store[(0+1)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .a3(A_store[(0+2)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .b1(B_store[INPUT_UNIT_LEN*(0+i)+:INPUT_UNIT_LEN]),
        //       .b2(B_store[INPUT_UNIT_LEN*(3+i)+:INPUT_UNIT_LEN]),
        //       .b3(B_store[INPUT_UNIT_LEN*(6+i)+:INPUT_UNIT_LEN])
        //     );
        
        //   end
        // end
        // 2'd1:begin
        //   for(i = 0;i<MATRIX_SIZE;i = i+1)begin
        //     C_store[OUTPUT_UNIT_LEN*(3+i)+:OUTPUT_UNIT_LEN] <= add_sum(
        //       .a1(A_store[(3+0)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .a2(A_store[(3+1)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .a3(A_store[(3+2)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .b1(B_store[INPUT_UNIT_LEN*(0+i)+:INPUT_UNIT_LEN]),
        //       .b2(B_store[INPUT_UNIT_LEN*(3+i)+:INPUT_UNIT_LEN]),
        //       .b3(B_store[INPUT_UNIT_LEN*(6+i)+:INPUT_UNIT_LEN])
        //     );
        
        //   end
        // end
        // 2'd0:begin
        //   for(i = 0;i<MATRIX_SIZE;i = i+1)begin
        //     C_store[OUTPUT_UNIT_LEN*(6+i)+:OUTPUT_UNIT_LEN] <= add_sum(
        //       .a1(A_store[(6+0)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .a2(A_store[(6+1)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .a3(A_store[(6+2)*INPUT_UNIT_LEN+:INPUT_UNIT_LEN]),
        //       .b1(B_store[INPUT_UNIT_LEN*(0+i)+:INPUT_UNIT_LEN]),
        //       .b2(B_store[INPUT_UNIT_LEN*(3+i)+:INPUT_UNIT_LEN]),
        //       .b3(B_store[INPUT_UNIT_LEN*(6+i)+:INPUT_UNIT_LEN])
        //     );
        
        //   end
        // end
        
        //default:C_store <= C_store;
        
        //endcase
        
    end
    else C_store <= C_store;
    
    end
    
    function [OUTPUT_UNIT_LEN-1:0] add_sum;
        input [INPUT_UNIT_LEN-1:0] a1 ,a2 ,a3, b1, b2, b3;
        
        reg [OUTPUT_UNIT_LEN-2:0] temp1, temp2, temp3;
        begin
            temp1   = a1*b1;
            temp2   = a2*b2;
            temp3   = a3*b3;
            add_sum = temp1+temp2+temp3;
        end
    endfunction
    
    
    always @(posedge clk) begin
        if (!reset_n)valid_store <= 0;
        else if (enable && current_state == S_OUT) valid_store <= 1;
        else valid_store <= 0;
    end
    
    //output
    assign C_mat = C_store;
    assign valid = valid_store;
    
endmodule
