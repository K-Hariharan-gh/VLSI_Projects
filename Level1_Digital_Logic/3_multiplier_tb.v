`timescale 1ns/1ps

module multiplier_2x2_tb;

reg [1:0] A;
reg [1:0] B;

wire [3:0] P;

multiplier_2x2 uut(
    .A(A),
    .B(B),
    .P(P)
);

integer i, j;

initial begin

    $dumpfile("3_multiplier_2x2.vcd");
    $dumpvars(0, multiplier_2x2_tb);

    for(i = 0; i < 4; i = i + 1)
    begin
        for(j = 0; j < 4; j = j + 1)
        begin
            A = i;
            B = j;
            #10;
        end
    end

    $finish;
end

endmodule