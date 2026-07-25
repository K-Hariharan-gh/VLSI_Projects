`timescale 1ns/1ps

module uart_rx_tb;

reg clk;
reg reset;
reg rx;

wire [7:0] data_out;
wire data_ready;

uart_rx uut(

    .clk(clk),
    .reset(reset),
    .rx(rx),

    .data_out(data_out),
    .data_ready(data_ready)

);

always #5 clk = ~clk;

initial
begin

    $dumpfile("2_uart_rx.vcd");
    $dumpvars(0, uart_rx_tb);

    clk = 0;
    reset = 1;
    rx = 1;

    #10;
    reset = 0;

    // Start Bit
    #10 rx = 0;

    // Data = 10101010 (LSB First)
    #10 rx = 0;
    #10 rx = 1;
    #10 rx = 0;
    #10 rx = 1;
    #10 rx = 0;
    #10 rx = 1;
    #10 rx = 0;
    #10 rx = 1;

    // Stop Bit
    #10 rx = 1;

    #40;

    $finish;

end

endmodule