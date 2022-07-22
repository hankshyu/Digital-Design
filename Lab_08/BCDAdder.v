module BCDAdder #(parameter SIZE = 8)
                 (input [SIZE*4-1:0] A,
                  input [SIZE*4-1:0] B,
                  output [SIZE*4-1:0] Answer);
    
    wire [SIZE-1:0] carry;
    genvar i;
    BCDUnitAdder A0(
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(0),
        .Sum(Answer[3:0]),
        .Carry(carry[0])
    );
    for (i=1;i<SIZE;i=i+1)begin
        BCDUnitAdder unit(
        .A(A[4*i+:4]),
        .B(B[4*i+:4]),
        .Cin(carry[i-1]),
        .Sum(Answer[4*i+:4]),
        .Carry(carry[i])
    );
    end
    
endmodule
