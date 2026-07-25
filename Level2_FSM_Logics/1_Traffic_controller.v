module traffic_controller(

    input clk,
    input reset,
    input ped_button,

    output reg NS_R,
    output reg NS_Y,
    output reg NS_G,

    output reg EW_R,
    output reg EW_Y,
    output reg EW_G

);

reg [2:0] state;
reg [2:0] count;
reg ped_request;

parameter S0 = 2'b000;
parameter S1 = 2'b001;
parameter S2 = 2'b010;
parameter S3 = 2'b011;
parameter S4 = 3'b100;

always @(posedge clk or posedge reset)
begin

    if(reset)
    begin
        state <= S0;
        count <= 0;
        ped_request <= 0;
    end

    else
    begin
        if(ped_button)
            ped_request <= 1;

        case(state)

            S0:
            begin
                if(count == 4)
                begin
                    state <= S1;
                    count <= 0;
                end
                else
                    count <= count + 1;
            end

            S1:
            begin
                if(count == 1)
                begin

                    if(ped_request)
                        state <= S4;
                    else
                        state <= S2;

                    count <= 0;

                end
                else
                    count <= count + 1;
            end 

            S2:
            begin
                if(count == 4)
                begin
                    state <= S3;
                    count <= 0;
                end
                else
                    count <= count + 1;
            end

            S3:
            begin
                if(count == 1)
                begin
                    state <= S0;
                    count <= 0;
                end
                else
                    count <= count + 1;
            end

            S4:
            begin

                if(count == 2)
                begin
                    state <= S2;
                    count <= 0;
                    ped_request <= 0;
                end

                else
                    count <= count + 1;
            end

        endcase

    end

end

always @(*)
begin

    NS_R = 0;
    NS_Y = 0;
    NS_G = 0;

    EW_R = 0;
    EW_Y = 0;
    EW_G = 0;

    case(state)

        S0:
        begin
            NS_G = 1;
            EW_R = 1;
        end

        S1:
        begin
            NS_Y = 1;
            EW_R = 1;
        end

        S2:
        begin
            NS_R = 1;
            EW_G = 1;
        end

        S3:
        begin
            NS_R = 1;
            EW_Y = 1;
        end

        S4:
        begin
            NS_R = 1;
            EW_R = 1;
        end

    endcase

end

endmodule