`timescale 1ns / 1ps

module block_ram(
    input clk,

    input ena,
    input wea,
    input [7:0] addra,
    input [23:0] dina,
    output reg [23:0] douta,

    input enb,
    input web,
    input [7:0] addrb,
    input [23:0] dinb,
    output reg [23:0] doutb

);

    reg [23:0] memory [255:0];

    always @(posedge clk ) begin
        if (ena) begin
            if(wea) begin
                memory[addra] <= dina;
                douta <= 24'dx;
            end
            else begin
                douta <= memory[addra];
            end
        end
        else begin
            douta <= 24'dx;
        end
        if (enb) begin
            if(web) begin
                memory[addrb] <= dinb;
                doutb <= 24'dx;
            end
            else begin
                doutb <= memory[addrb];
            end
        end
        else begin
            doutb <= 24'dx;
        end
    end




endmodule
