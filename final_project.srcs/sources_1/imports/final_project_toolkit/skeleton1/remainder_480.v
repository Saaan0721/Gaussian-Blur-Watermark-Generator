`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/01 15:20:31
// Design Name: 
// Module Name: remainder_480
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


module remainder_480(
    input [8:0] a,
    output reg [8:0] b
    );
    
    adder_9bit U0(
        .a(a),
        .b(9'd32),
        .sum(W)
    );
   
    
    wire [8:0] W;
    reg [8:0] a1;
    
    always @(W) begin
        a1=a;
        if(a1 >= 9'd480) begin
            b=W;
         end
         else b=a1;
    end
    
endmodule
