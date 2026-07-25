`timescale 1ns/1ps

module uart_loop_tb;

reg clk;
reg reset;
reg start;
reg [7:0] tx_data;

// Wire connecting TX and RX
wire tx;

// Receiver outputs
wire [7:0] rx_data;
wire data_ready;

//------------------------
// UART Transmitter
//------------------------
uart_tx transmitter(

    .clk(clk),
    .reset(reset),
    .start(start),
    .data_in(tx_data),
    .tx(tx)

);

//------------------------
// UART Receiver
//------------------------
uart_rx receiver(

    .clk(clk),
    .reset(reset),
    .rx(tx),

    .data_out(rx_data),
    .data_ready(data_ready)

);

// Clock
always #5 clk = ~clk;

initial
begin

    $dumpfile("3_uart_loop.vcd");
    $dumpvars(0, uart_loop_tb);

    clk = 0;
    reset = 1;
    start = 0;
    tx_data = 8'hAA;

    #10;
    reset = 0;

    // Begin transmission
    #10;
    start = 1;

    #10;
    start = 0;

    // Wait until transmission completes
    #250;

    $finish;

end

endmodule