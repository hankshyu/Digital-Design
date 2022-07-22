module SeqMultiplierTA (
    input  wire           clk,
    input  wire           enable,
    input  wire [7:0]     A,
    input  wire [7:0]     B,
    output wire [15:0]    C
);

    localparam [1:0] M_IDEL = 0,
                     M_MUL  = 1,
                     M_OUT  = 2;

    reg [1:0] c_state, n_state;
    reg [3:0] idx;
    reg [7:0] A_reg, B_reg;
    reg [15:0] C_reg;

    wire mul_fin;

    // FSM

    always @(posedge clk) begin
        if (~enable) c_state <= M_IDEL;
        else c_state <= n_state;
    end

    always @(*) begin
        case (c_state) 
            M_IDEL:
                if (enable) n_state = M_MUL;
                else n_state = M_IDEL;
            M_MUL:
                if (mul_fin) n_state = M_OUT;
                else n_state = M_MUL;
            M_OUT:
                n_state = M_IDEL;
            default: n_state = M_IDEL;
        endcase
    end

    always @(posedge clk) begin
        if (c_state == M_IDEL) idx <= 7;
        else if (c_state == M_MUL) idx <= idx - 1;
    end

    assign mul_fin = (idx == 0);
    
    // MUL Logic
    wire C_accumulate;
    wire [15:0] C_sl_one;

    assign C_accumulate = (B_reg & 8'h80) == 8'h80;
    assign C_sl_one = C_reg << 1;

    always @(posedge clk) begin
        if (c_state == M_IDEL && enable) A_reg <= A;
    end

    always @(posedge clk) begin
        if (c_state == M_IDEL && enable) B_reg <= B;
        else if (c_state == M_MUL) B_reg <= B_reg << 1; 
    end

    always @(posedge clk) begin
        if (c_state == M_IDEL && enable) C_reg <= 0;
        else if (c_state == M_MUL) C_reg <= C_accumulate ? C_sl_one + A_reg : C_sl_one;
    end

    // Output Logic 

    assign C = C_reg;

endmodule