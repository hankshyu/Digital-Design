`define CYCLE_TIME 10

module SeqMultiplierTA_tb;

    integer SEED = 0;

    reg         clk;
    reg         enable;
    reg  [7:0]  A, B;
    reg  [15:0] golden_C;
    wire [15:0] C;

    integer pat_idx;
    integer i;

    always #(`CYCLE_TIME / 2.0) clk = ~clk;
    initial clk = 0;

    SeqMultiplierTA DUT(
        .clk(clk),
        .enable(enable),
        .A(A),
        .B(B),
        .C(C)
    );


    initial begin

        A = 0;
        B = 0;
        enable = 0;
        @(negedge clk);


        for (pat_idx = 0; pat_idx < 10000; pat_idx = pat_idx + 1) begin
            // in pat
            A = $random(SEED);
            B = $random(SEED);
            $display("* Input pattern: ");
            $display("    - A: %d", A);
            $display("    - B: %d", B);
            enable = 1;
            @(negedge clk);
            // wait for 8 cycles
            for (i = 0; i < 8; i = i + 1) @(negedge clk);
            // check ans
            golden_C = A * B;
            $display("    - C v.s Golden C: %d v.s %d", C, golden_C);
            if (C !== golden_C) begin
                $display("Wrong!");
                $finish;
            end
            $display("--------------------------------");
            enable = 0;
            @(negedge clk);

        end
        $display("Pass");

        $finish;
    end

endmodule
