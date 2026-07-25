module full_adder(
    input A,
    input B,
    input Cin,
    output SUM,
    output Cout
);

assign SUM  = A ^ B ^ Cin;
assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule