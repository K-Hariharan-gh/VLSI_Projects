module uart_rx(

    input clk,
    input reset,
    input rx,

    output reg [7:0] data_out,
    output reg data_ready

);

reg [1:0] state;
reg [2:0] bit_index;
reg [7:0] shift_reg;

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= IDLE;
        bit_index <= 0;
        shift_reg <= 8'b0;
        data_out <= 8'b0;
        data_ready <= 0;
    end

    else
    begin

        data_ready <= 0;

        case(state)

            IDLE:
            begin
                if(rx == 0)
                begin
                    state <= START;
                end
            end

            START:
            begin
                bit_index <= 0;
                state <= DATA;
            end

            DATA:
            begin

                shift_reg[bit_index] <= rx;

                if(bit_index == 7)
                    state <= STOP;

                else
                    bit_index <= bit_index + 1;

            end

            STOP:
            begin

                if(rx == 1)
                begin
                    data_out <= shift_reg;
                    data_ready <= 1;
                end

                state <= IDLE;

            end

        endcase

    end

end

endmodule