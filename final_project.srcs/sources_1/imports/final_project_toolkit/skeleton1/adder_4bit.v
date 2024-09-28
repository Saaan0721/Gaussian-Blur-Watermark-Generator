`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 23:24:06
// Design Name: 
// Module Name: adder_4bit
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


module adder_4bit (
  input [3:0] a,
  input [3:0] b,
  output reg [3:0] sum
);

  reg carry;

  always @(a or b) begin
    sum[0] = a[0] ^ b[0] ^ 1'b0;
    carry = (a[0] & b[0]) | ((a[0] ^ b[0]) & 1'b0);

    sum[1] = a[1] ^ b[1] ^ carry;
    carry = (a[1] & b[1]) | ((a[1] ^ b[1]) & carry);

    sum[2] = a[2] ^ b[2] ^ carry;
    carry = (a[2] & b[2]) | ((a[2] ^ b[2]) & carry);

    sum[3] = a[3] ^ b[3] ^ carry;

  end

endmodule
