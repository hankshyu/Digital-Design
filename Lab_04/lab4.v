`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dept. of CS, National Chiao Tung University
// Engineer: Chun-Jen Tsai, hankshyu
//
// Create Date: 2017/04/27 15:06:57 && 2021/07/12 10:53:17
// Design Name: UART I/O example for Arty
// Module Name: lab4
// Project Name:
// Target Devices: Xilinx FPGA @ 100MHz
// Tool Versions:
// Description:
//
// The parameters for the UART controller are 9600 baudrate, 8-N-1-N
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module lab4(input clk,
            input reset_n,
            input [3:0] usr_btn,
            output [3:0] usr_led,
            input uart_rx,
            output uart_tx);
    
    //FSM for main controller
    
    reg [3:0] P, P_next;
    localparam [3:0] S_MAIN_INIT         = 0;
    localparam [3:0] S_MAIN_A_PROMPT     = 1;
    localparam [3:0] S_MAIN_A_WAIT_KEY   = 2;
    localparam [3:0] S_MAIN_A_PRINT      = 3;
    localparam [3:0] S_MAIN_A_TRANSITION = 4;
    localparam [3:0] S_MAIN_B_PROMPT     = 5;
    localparam [3:0] S_MAIN_B_WAIT_KEY   = 6;
    localparam [3:0] S_MAIN_B_PRINT      = 8;
    localparam [3:0] S_MAIN_B_TRANSITION = 7 ;
    localparam [3:0] S_MAIN_CAL_GCD      = 9;
    localparam [3:0] S_MAIN_PRINT_ANSWER = 10;
    
    //FSM for sending string to UART
    reg [1:0] Q, Q_next;
    localparam [1:0] S_UART_IDLE = 0;
    localparam [1:0] S_UART_WAIT = 1;
    localparam [1:0] S_UART_SEND = 2;
    localparam [1:0] S_UART_INCR = 3;
    
    localparam INIT_DELAY         = 100_000; // 1 msec @ 100 MHz
    localparam MEM_SIZE           = 96;
    localparam A_STR_POSITION     = 0;
    localparam B_STR_POSITION     = 33;
    localparam GCD_STR_POSITION   = 69;
    localparam INPUT_STR_POSITION = 94;
    
    // declare system variables
    wire enter_pressed;
    wire print_enable, print_done;
    wire input_valid;
    reg [$clog2(MEM_SIZE):0] send_counter;
    reg [$clog2(INIT_DELAY):0] init_counter;
    reg [7:0] data[0:MEM_SIZE-1];
    
    // declare UART signals
    wire transmit;
    wire received;
    wire [7:0] rx_byte;
    reg  [7:0] rx_temp;
    wire [7:0] tx_byte;
    wire is_receiving;
    wire is_transmitting;
    wire recv_error;
    
    //gcd_calculator signals
    wire gcd_rst_n;
    wire gcd_enable;
    reg [15:0] gcd_A;
    reg [15:0] gcd_B;
    wire [15:0] gcd_result;
    wire gcd_done;
    
    /* The UART device takes a 100MHz clock to handle I/O at 9600 baudrate */
    uart uart(
    .clk(clk),
    .rst(~reset_n),
    .rx(uart_rx),
    .tx(uart_tx),
    .transmit(transmit),
    .tx_byte(tx_byte),
    .received(received),
    .rx_byte(rx_byte),
    .is_receiving(is_receiving),
    .is_transmitting(is_transmitting),
    .recv_error(recv_error)
    );
    
    gcd_calculator gcd_calculator(
    .clk(clk),
    .rst_n(gcd_rst_n),
    .enable(gcd_enable),
    .A(gcd_A),
    .B(gcd_B),
    .answer(gcd_result),
    .answer_available(gcd_done)
    );
    
    
    initial begin
        //data[0:32]
        { data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7],
        data[8], data[9], data[10], data[11], data[12], data[13], data[14], data[15],
        data[16], data[17], data[18], data[19], data[20], data[21], data[22], data[23],
        data[24], data[25], data[26], data[27], data[28], data[29], data[30], data[31],
        data[32]  } <= {"Enter the first decimal number: ",8'h00};
        
        //data[33:68]
        { data[33], data[34], data[35], data[36], data[37], data[38], data[39], data[40],
        data[41], data[42], data[43], data[44], data[45], data[46], data[47], data[48],
        data[49], data[50], data[51], data[52], data[53], data[54], data[55], data[56],
        data[57], data[58], data[59], data[60], data[61], data[62], data[63], data[64],
        data[65], data[66], data[67], data[68]  } <= {8'h0D, 8'h0A,"Enter the second decimal number: ",8'h00};
        
        //data[69:93], data[85:88] is the answer: 0x[answer]
        { data[69], data[70], data[71], data[72], data[73], data[74], data[75], data[76],
        data[77], data[78], data[79], data[80], data[81], data[82], data[83], data[84],
        data[85], data[86], data[87], data[88], data[89], data[90], data[91], data[92],
        data[93]  } <= {8'h0D, 8'h0A,"The GCD is: ","0x9999",8'h0D, 8'h0A, 8'h0D, 8'h0A, 8'h0};
        
        data[94] <= "7";
        data[95] <= 8'h00;
    end
    
    // Combinational I/O logics
    assign usr_led       = usr_btn;
    assign enter_pressed = (rx_temp == 8'h0D);
    assign tx_byte       = data[send_counter];
    assign input_valid   = (rx_temp > 8'h2F && rx_temp < 8'h3A);
    
    //gcd signals
    assign gcd_rst_n  = ~(P != S_MAIN_CAL_GCD && P_next == S_MAIN_CAL_GCD);
    assign gcd_enable = (P == S_MAIN_CAL_GCD);
    
    // ------------------------------------------------------------------------
    // Main FSM that reads the UART input and triggers
    always @(posedge clk) begin
        if (~reset_n) P <= S_MAIN_INIT;
        else P          <= P_next;
    end
    
    always @(*) begin // FSM next-state logic
        case (P)
            S_MAIN_INIT:
            P_next = (init_counter>INIT_DELAY)?S_MAIN_A_PROMPT:S_MAIN_INIT;
            
            S_MAIN_A_PROMPT:
            P_next = (print_done)? S_MAIN_A_WAIT_KEY:S_MAIN_A_PROMPT;
            
            S_MAIN_A_WAIT_KEY:
            begin
                if (enter_pressed) P_next    = S_MAIN_A_TRANSITION;
                else if (input_valid) P_next = S_MAIN_A_PRINT;
                else P_next                  = S_MAIN_A_WAIT_KEY;
            end
            
            S_MAIN_A_PRINT:
            P_next = (print_done)? S_MAIN_A_WAIT_KEY:S_MAIN_A_PRINT;
            
            S_MAIN_A_TRANSITION: P_next = S_MAIN_B_PROMPT;
            
            S_MAIN_B_PROMPT:
            P_next = (print_done)?S_MAIN_B_WAIT_KEY:S_MAIN_B_PROMPT;
            
            S_MAIN_B_WAIT_KEY:
            begin
                if (enter_pressed) P_next   = S_MAIN_B_TRANSITION;
                else if (input_valid)P_next = S_MAIN_B_PRINT;
                else P_next                 = S_MAIN_B_WAIT_KEY;
            end
            
            S_MAIN_B_PRINT:
            P_next = (print_done)?S_MAIN_B_WAIT_KEY:S_MAIN_B_PRINT;
            
            S_MAIN_B_TRANSITION:
            P_next = S_MAIN_CAL_GCD;
            
            S_MAIN_CAL_GCD:
            P_next = (gcd_done)?S_MAIN_PRINT_ANSWER:S_MAIN_CAL_GCD;
            
            S_MAIN_PRINT_ANSWER:
            P_next = (print_done)?S_MAIN_INIT:S_MAIN_PRINT_ANSWER;
            
            default: P_next = S_MAIN_INIT;
            
        endcase
    end
    
    // FSM output logics: print string control signals.
    assign print_enable = 
    (P != S_MAIN_A_PROMPT && P_next == S_MAIN_A_PROMPT) ||
    (P != S_MAIN_B_PROMPT && P_next == S_MAIN_B_PROMPT)||
    (P != S_MAIN_A_PRINT && P_next == S_MAIN_A_PRINT)||
    (P != S_MAIN_B_PRINT && P_next == S_MAIN_B_PRINT)||
    (P != S_MAIN_PRINT_ANSWER && P_next == S_MAIN_PRINT_ANSWER);
    
    assign print_done = (tx_byte == 8'h0);
    
    //init_counter ticks to count 1ms delay to begin at S_MAIN_INIT, resets at other state.
    always @(posedge clk) begin
        if (P == S_MAIN_INIT) init_counter <= init_counter + 1;
        else init_counter <= 0;
    end
    
    // End of the FSM of the print string controller
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    // FSM of the controller to send a string to the UART.
    always @(posedge clk) begin
        if (~reset_n) Q <= S_UART_IDLE;
        else Q          <= Q_next;
    end
    
    always @(*) begin // FSM next-state logic
        case (Q)
            S_UART_IDLE: // wait for the print_string flag
            if (print_enable) Q_next = S_UART_WAIT;
            else Q_next              = S_UART_IDLE;
            S_UART_WAIT: // wait for the transmission of current data byte begins
            if (is_transmitting == 1) Q_next = S_UART_SEND;
            else Q_next         = S_UART_WAIT;
            S_UART_SEND: // wait for the transmission of current data byte finishes
            if (is_transmitting == 0) Q_next = S_UART_INCR; // transmit next character
            else Q_next         = S_UART_SEND;
            S_UART_INCR:
            if (tx_byte == 8'h0) Q_next = S_UART_IDLE; // string transmission ends
            else Q_next = S_UART_WAIT;
        endcase
    end
    
    // FSM output logics
    assign transmit = (Q_next == S_UART_WAIT || print_enable);
    
    // UART send_counter control circuit
    always @(posedge clk) begin
        case (P_next)
            S_MAIN_INIT: send_counter         <= A_STR_POSITION;
            S_MAIN_A_WAIT_KEY:send_counter    <= INPUT_STR_POSITION;
            S_MAIN_A_TRANSITION: send_counter <= B_STR_POSITION;
            S_MAIN_B_WAIT_KEY:send_counter    <= INPUT_STR_POSITION;
            S_MAIN_CAL_GCD:send_counter       <= GCD_STR_POSITION;
            
            default: send_counter <= send_counter + (Q_next == S_UART_INCR);
        endcase
    end
    
    // End of the FSM of the print string controller
    // ------------------------------------------------------------------------
    
    // ------------------------------------------------------------------------
    // The following logic stores the UART input in a temporary buffer.
    // The input character will stay in the buffer for one clock cycle.
    
    always @(posedge clk) begin
        rx_temp <= (received)? rx_byte : 8'h0;
    end
    
    always @(posedge clk) begin
        if (P == S_MAIN_INIT)gcd_A <= 0;
        else if (P == S_MAIN_A_WAIT_KEY && received && rx_byte >= "0" && rx_byte <= "9")begin
        gcd_A <= gcd_A * 10 + rx_byte - "0";
    end
    end
    
    always @(posedge clk) begin
        if (P == S_MAIN_INIT) gcd_B <= 0;
        else if (P == S_MAIN_B_WAIT_KEY && received && rx_byte >= "0" && rx_byte <= "9")begin
        gcd_B <= gcd_B * 10 + rx_byte - "0";
    end
    end
    
    always @(posedge clk) begin
        
        if (P == S_MAIN_PRINT_ANSWER && P_next == S_MAIN_PRINT_ANSWER) begin
            data[85] <= binaryToAscii(.binary(gcd_result[15:12]));
            data[86] <= binaryToAscii(.binary(gcd_result[11:8]));
            data[87] <= binaryToAscii(.binary(gcd_result[7:4]));
            data[88] <= binaryToAscii(.binary(gcd_result[3:0]));
        end
    end
    
    always @(posedge clk) begin
        if (received && rx_byte >= "0" && rx_byte <= "9")
            data[INPUT_STR_POSITION] <= rx_byte;
            end
        
        function [7:0] binaryToAscii;
            input [3:0] binary;
            reg [7:0] answer_store;
            begin
                if (binary < 10) answer_store = binary + "0";
                else answer_store             = binary + "A" - 10;
                
                binaryToAscii = answer_store;
            end
            
        endfunction
        
        always @(posedge clk) begin
            rx_temp <= (received)? rx_byte : 8'h00;
        end
        
        // ------------------------------------------------------------------------
        
        endmodule
        
