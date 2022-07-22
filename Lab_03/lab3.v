`timescale 1ns / 1ps

module lab3(input clk,
            input reset_n,
            input [3:0] usr_btn,
            output [3:0] usr_led);
    
    
    reg signed [3:0] number, reg_usr_led;
    
    reg[31:0] bouncing_counter, freq_counter, freq_threshold;
    
    reg[6:0] CURRENT_STATE, NEXT_STATE;
    
    localparam S_IDLE         = 7'd1 ;
    localparam S_RST          = 7'd2 ;
    localparam S_RESET_BOUNCE = 7'd4 ;
    localparam S_NUM_UP       = 7'd8 ;
    localparam S_NUM_DOWN     = 7'd16 ;
    localparam S_FREQ_UP      = 7'd32 ;
    localparam S_FREQ_DOWN    = 7'd64 ;
    
    localparam BOUNCING_WINDOW = 15_000_000 ;//0.15 second window
    localparam PWM_100         = 1_000_000;//100hertz pwm pulse
    localparam PWM_50          = 500_000;
    localparam PWM_25          = 250_000;
    localparam PWM_5           = 50_000;
    
    //FSM
    always @(posedge clk, negedge reset_n) begin
        if (!reset_n)CURRENT_STATE <= S_RST;
        else CURRENT_STATE         <= NEXT_STATE;
    end
    
    wire bouncing_counter_ends;
    assign bouncing_counter_ends = (bouncing_counter == 0);
    
    always @(*) begin
        
        case(CURRENT_STATE)
            S_IDLE:begin
                if (!reset_n)NEXT_STATE                                 = S_RST;
                else if (usr_btn[0] && bouncing_counter_ends)NEXT_STATE = S_NUM_DOWN;
                else if (usr_btn[1] && bouncing_counter_ends)NEXT_STATE = S_NUM_UP;
                else if (usr_btn[2] && bouncing_counter_ends)NEXT_STATE = S_FREQ_DOWN;
                else if (usr_btn[3] && bouncing_counter_ends)NEXT_STATE = S_FREQ_UP;
                else NEXT_STATE                                         = S_IDLE ;
            end
            S_RST:NEXT_STATE           = S_IDLE;
            S_RESET_BOUNCE: NEXT_STATE = S_IDLE;
            S_NUM_UP: NEXT_STATE       = S_RESET_BOUNCE;
            S_NUM_DOWN: NEXT_STATE     = S_RESET_BOUNCE;
            S_FREQ_UP: NEXT_STATE      = S_RESET_BOUNCE;
            S_FREQ_DOWN: NEXT_STATE    = S_RESET_BOUNCE;
            default: NEXT_STATE        = S_IDLE;
        endcase
    end
    
    always @(posedge clk) begin
        if (CURRENT_STATE == S_RST)number      <= 0;
        else if (CURRENT_STATE == S_NUM_UP && number <7) number <= number+1;
        else if (CURRENT_STATE == S_NUM_DOWN && number >-8) number <= number -1;
        
    end
    
    always @(posedge clk) begin
        if (CURRENT_STATE == S_RST || CURRENT_STATE == S_RESET_BOUNCE) bouncing_counter <= BOUNCING_WINDOW;
        else if (bouncing_counter >0) bouncing_counter <= bouncing_counter-1;
        
    end
    
    always @(posedge clk) begin
        if (CURRENT_STATE == S_RST || freq_counter == 0) freq_counter <= 1_000_000;
        else if (freq_counter>0) freq_counter <= freq_counter-1;
        
    end
    
    always @(posedge clk) begin
        if (CURRENT_STATE == S_RST) freq_threshold <= PWM_50;
        else if (CURRENT_STATE == S_FREQ_UP && freq_threshold == PWM_5) freq_threshold <= PWM_25;
        else if (CURRENT_STATE == S_FREQ_UP && freq_threshold <PWM_100) freq_threshold <= freq_threshold+PWM_25;
        else if (CURRENT_STATE == S_FREQ_DOWN && freq_threshold == PWM_25) freq_threshold <= PWM_5;
        else if (CURRENT_STATE == S_FREQ_DOWN && freq_threshold > PWM_25) freq_threshold <= freq_threshold-PWM_25;
        
    end
    //output logic

    always @(posedge clk) begin
        if(freq_counter>freq_threshold)reg_usr_led<=0;
        else reg_usr_led<=number;
        
    end
    
    assign usr_led = reg_usr_led;
endmodule
    
