`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/01 17:04:07
// Design Name: 
// Module Name: remainder_640
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


module remainder_640(
    input [9:0] a,
    output reg [9:0] b
    );
    
    adder_10bit U0(
        .a(a),
        .b(10'd384),
        .sum(W)
    );
   
    
    wire [9:0] W;
    reg [9:0] a1;
    
    always @(W) begin
        a1=a;
        if(a1 >= 10'd640) begin
            b=W;
         end
         else b=a1;
    end
    
endmodule
