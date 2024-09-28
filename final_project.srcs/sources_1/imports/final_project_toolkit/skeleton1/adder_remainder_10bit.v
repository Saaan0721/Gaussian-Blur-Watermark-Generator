`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/01 17:35:36
// Design Name: 
// Module Name: adder_remainder_10bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder_remainder_10bit(
    input [9:0] start_col,
    input [9:0] add,
    output reg [9:0] col_out
    );
    
    adder_10bit U0(
        .a(start_col),
        .b(add),
        .sum(W0)
    );
    
    remainder_640 U1(
        .a(W0),
        .b(W1)
    );
    
    wire [9:0] W0;
    wire [9:0] W1;
    
    always @(W0 or W1) begin
        col_out = W1;
    end
    
endmodule
