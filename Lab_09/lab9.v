`timescale 1ns / 1ps

module lab9(input clk,
            input reset_n,
            input [3:0] usr_btn,
            output [3:0] usr_led,
            output LCD_RS,
            output LCD_RW,
            output LCD_E,
            output [3:0] LCD_D);
    
    localparam S_INIT = 3'b001;
    localparam S_CAL  = 3'b010;
    localparam S_SHOW = 3'b100;
    reg  [2:0]        P;
    reg  [2:0]        P_next;
    
    // declare system variables
    wire         btn_level, btn_pressed;
    reg          prev_btn_level;
    
    reg  [127:0] row_A;
    reg  [127:0] row_B;
    
    reg ld_rst_n;
    wire signed[21:0] ld_maxproduct;
    wire [$clog2(960):0] ld_maxproductlocation;
    wire ld_done;
    
    
    LCD_module lcd0(
    .clk(clk),
    .reset(~reset_n),
    .row_A(row_A),
    .row_B(row_B),
    .LCD_E(LCD_E),
    .LCD_RS(LCD_RS),
    .LCD_RW(LCD_RW),
    .LCD_D(LCD_D)
    );
    
    debounce btn_db0(
    .clk(clk),
    .btn_input(usr_btn[0]),
    .btn_output(btn_level)
    );
    
    load_data ld(
    .clk(clk),
    .rst_n(ld_rst_n),
    .usr_btn(usr_btn),
    .maxproduct_out(ld_maxproduct),
    .maxproductlocation_out(ld_maxproductlocation),
    .done(ld_done)
    );
    
    assign usr_led = 4'h00;//turn off the led
    
    //
    // Enable one cycle of btn_pressed per each button hit
    //
    always @(posedge clk) begin
        if (~reset_n)
            prev_btn_level <= 0;
        else
            prev_btn_level <= btn_level;
    end
    
    assign btn_pressed = (btn_level & ~prev_btn_level);
    
    // ------------------------------------------------------------------------
    // FSM of the main controller
    always @(posedge clk) begin
        if (~reset_n) begin
            P <= S_INIT;
        end
        else begin
            P <= P_next;
        end
    end
    
    always @(*) begin // FSM next-state logic
        case (P)
            S_INIT:P_next = (btn_pressed)?S_CAL:S_INIT;
            
            S_CAL:P_next = (ld_done)?S_SHOW:S_CAL;
            
            S_SHOW:P_next = S_SHOW;
            
            default:P_next = S_INIT;
        endcase
    end
    
    // End of the main controller
    // ------------------------------------------------------------------------
    always @(posedge clk) begin
        if (P == S_INIT)ld_rst_n <= 0;
        else ld_rst_n <= 1;
    end
    // ------------------------------------------------------------------------
    // The following code updates the 1602 LCD text messages.
    
    always @(posedge clk) begin
        if (P == S_INIT)begin
            row_A <= "Press BTN0 to do";
            row_B <= "x-correlation...";
        end
        else if (P == S_SHOW)begin
            row_A <= {"Max value ",
            binarytoAscii(ld_maxproduct[21:20]),binarytoAscii(ld_maxproduct[16+:4]),binarytoAscii(ld_maxproduct[12+:4])
            ,binarytoAscii(ld_maxproduct[8+:4]),binarytoAscii(ld_maxproduct[4+:4]),binarytoAscii(ld_maxproduct[0+:4])
            };
            row_B <= {"Max location ",
            binarytoAscii(ld_maxproductlocation[9:8]),binarytoAscii(ld_maxproductlocation[7:4]),binarytoAscii(ld_maxproductlocation[3:0])
            };
        end
    end
            
    function [7:0] binarytoAscii;
        input [3:0] x;
        begin
            binarytoAscii = (x>9)?"A"+x-10:"0"+x;
        end
        
    endfunction
    
    endmodule
