`timescale 1ns/1ps

module traffic_controller_tb;

reg clk;
reg reset;
reg ped_button;

wire NS_R;
wire NS_Y;
wire NS_G;

wire EW_R;
wire EW_Y;
wire EW_G;

traffic_controller uut(

    .clk(clk),
    .reset(reset),
    .ped_button(ped_button),

    .NS_R(NS_R),
    .NS_Y(NS_Y),
    .NS_G(NS_G),

    .EW_R(EW_R),
    .EW_Y(EW_Y),
    .EW_G(EW_G)

);

always #5 clk = ~clk;

initial begin

    $dumpfile("1_traffic_controller.vcd");
    $dumpvars(0, traffic_controller_tb);

    clk = 0;
    reset = 1;
    

    #10;
    reset = 0;

    ped_button = 0;

    #35;
    ped_button = 1;

    #10;
    ped_button = 0;

    #500;

    $finish;

end

endmodule