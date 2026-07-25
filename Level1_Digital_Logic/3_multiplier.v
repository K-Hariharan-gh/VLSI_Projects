module multiplier_2x2(
    input  [1:0] A,
    input  [1:0] B,
    output [3:0] P
);

wire pp0, pp1, pp2, pp3;
wire carry1;

// Partial Products

assign pp0 = A[0] & B[0];
assign pp1 = A[1] & B[0];
assign pp2 = A[0] & B[1];
assign pp3 = A[1] & B[1];

// Bit 0

assign P[0] = pp0;

// Add middle terms

half_adder HA1(
    .A(pp1),
    .B(pp2),
    .SUM(P[1]),
    .CARRY(carry1)
);

// Add final carry

half_adder HA2(
    .A(pp3),
    .B(carry1),
    .SUM(P[2]),
    .CARRY(P[3])
);

endmodule