`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2021/07/12 20:55:58
// Design Name:
// Module Name: debounce
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


module debounce(input clk,
                input btn_input,
                output btn_output);
    
    parameter DE_BOUNCE_CYCLE = 15_000_000 ; //0.15 sec wait time
    
    reg[$clog2(DE_BOUNCE_CYCLE):0] debounce_counter;
    wire debounce_counter_expire;
    
    localparam ZERO        = 0;
    localparam ZERO_TO_ONE = 1;
    localparam ONE         = 2;
    localparam ONE_TO_ZERO = 3;
    
    reg [1:0] current_state,next_state;
 
    
    initial begin
        {current_state[1],current_state[0]} <= {1'b0,1'b0};
    end
    
    always @(posedge clk) begin
        current_state <= next_state;
    end
    
    always @(*) begin
        case(current_state)
            ZERO: next_state       = (btn_input)?ZERO_TO_ONE:ZERO;
            ZERO_TO_ONE: next_state = (debounce_counter_expire)?ONE:ZERO_TO_ONE;
            ONE: next_state         = (!btn_input)?ONE_TO_ZERO:ONE;
            ONE_TO_ZERO: next_state = (debounce_counter_expire)?ZERO:ONE_TO_ZERO;
            
        endcase
    end
    
    always @(posedge clk) begin
        case(current_state)
            ZERO: debounce_counter<=0;
            ZERO_TO_ONE:debounce_counter<=debounce_counter+1;
            ONE:debounce_counter<=0;
            ONE_TO_ZERO:debounce_counter<=debounce_counter+1;
        endcase
        
    end
    
    assign debounce_counter_expire = (debounce_counter >= DE_BOUNCE_CYCLE);
    
    assign btn_output = (current_state == ZERO_TO_ONE || current_state == ONE);
    
    
    
endmodule
