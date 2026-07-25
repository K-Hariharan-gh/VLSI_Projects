`timescale 1ns/1ps

module uart_tx_tb;

reg clk;
reg reset;
reg start;
reg [7:0] data_in;

wire tx;
wire busy;

uart_tx uut (

    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(data_in),
    .tx(tx),
    .busy(busy)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("1_uart_tx.vcd");
    $dumpvars(0, uart_tx_tb);

    clk = 0;
    reset = 1;
    start = 0;
    data_in = 8'b10101010;

    #10;
    reset = 0;

    #10;
    start = 1;

    #10;
    start = 0;

    #150;

    $finish;

end

endmodule