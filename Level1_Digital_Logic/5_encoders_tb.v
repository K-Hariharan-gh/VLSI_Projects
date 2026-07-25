`timescale 1ns/1ps

module encoder_4to2_tb;

reg D0, D1, D2, D3;

wire Y0, Y1;

encoder_4to2 uut(
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3),
    .Y0(Y0),
    .Y1(Y1)
);

initial begin

    $dumpfile("5_encoder_4to2.vcd");
    $dumpvars(0, encoder_4to2_tb);

    D0=1; D1=0; D2=0; D3=0; #10;
    D0=0; D1=1; D2=0; D3=0; #10;
    D0=0; D1=0; D2=1; D3=0; #10;
    D0=0; D1=0; D2=0; D3=1; #10;

    $finish;

end

endmodule