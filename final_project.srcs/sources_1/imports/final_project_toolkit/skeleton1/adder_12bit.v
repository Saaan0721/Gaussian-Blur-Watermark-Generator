`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/04 12:57:11
// Design Name: 
// Module Name: adder_12bit
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


module adder_12bit (
  input [11:0] a,
  input [11:0] b,
  output reg [11:0] sum
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
    carry = (a[3] & b[3]) | ((a[3] ^ b[3]) & carry);

    sum[4] = a[4] ^ b[4] ^ carry;
    carry = (a[4] & b[4]) | ((a[4] ^ b[4]) & carry);

    sum[5] = a[5] ^ b[5] ^ carry;
    carry = (a[5] & b[5]) | ((a[5] ^ b[5]) & carry);

    sum[6] = a[6] ^ b[6] ^ carry;
    carry = (a[6] & b[6]) | ((a[6] ^ b[6]) & carry);

    sum[7] = a[7] ^ b[7] ^ carry;
    carry = (a[7] & b[7]) | ((a[7] ^ b[7]) & carry);

    sum[8] = a[8] ^ b[8] ^ carry;
    carry = (a[8] & b[8]) | ((a[8] ^ b[8]) & carry);

    sum[9] = a[9] ^ b[9] ^ carry;
    carry = (a[9] & b[9]) | ((a[9] ^ b[9]) & carry);
    
    sum[10] = a[10] ^ b[10] ^ carry;
    carry = (a[10] & b[10]) | ((a[10] ^ b[10]) & carry);
    
    sum[11] = a[11] ^ b[11] ^ carry;
    
  end

endmodule
