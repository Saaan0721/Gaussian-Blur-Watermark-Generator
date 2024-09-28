`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/05 01:47:12
// Design Name: 
// Module Name: divider_3
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


module divider_3(
    input [9:0] a,
    output reg [8:0] quotient,
    output reg [1:0] remainder
    );
    
    reg [9:0] temp;

    always @ (a) begin
        temp =a;
        quotient = 9'b0;
        remainder = 2'b0;

      if (temp[9:8] >= 2'd3) begin
        quotient[8] = 1;
        temp[9:8]=2'd0;
      end else quotient[8] = 0;
        
      if (temp[9:7] >= 3'd3) begin
        quotient[7] = 1;
        if(temp[9:7]==3'd3) temp[9:7]=3'd0;
        else if (temp[9:7]==3'd4) temp[9:7]=3'd1;
        else if (temp[9:7]==3'd5) temp[9:7]=3'd2;
      end else quotient[7] = 0;
      
      if (temp[8:6] >= 3'd3) begin
        quotient[6] = 1;
        if(temp[8:6]==3'd3) temp[8:6]=3'd0;
        else if (temp[8:6]==3'd4) temp[8:6]=3'd1;
        else if (temp[8:6]==3'd5) temp[8:6]=3'd2;
      end else quotient[6] = 0;
      
      if (temp[7:5] >= 3'd3) begin
        quotient[5] = 1;
        if(temp[7:5]==3'd3) temp[7:5]=3'd0;
        else if (temp[7:5]==3'd4) temp[7:5]=3'd1;
        else if (temp[7:5]==3'd5) temp[7:5]=3'd2;
      end else quotient[5] = 0;
      
      if (temp[6:4] >= 3'd3) begin
        quotient[4] = 1;
        if(temp[6:4]==3'd3) temp[6:4]=3'd0;
        else if (temp[6:4]==3'd4) temp[6:4]=3'd1;
        else if (temp[6:4]==3'd5) temp[6:4]=3'd2;
      end else quotient[4] = 0;
      
      if (temp[5:3] >= 3'd3) begin
        quotient[3] = 1;
        if(temp[5:3]==3'd3) temp[5:3]=3'd0;
        else if (temp[5:3]==3'd4) temp[5:3]=3'd1;
        else if (temp[5:3]==3'd5) temp[5:3]=3'd2;
      end else quotient[3] = 0;
      
      if (temp[4:2] >= 3'd3) begin
        quotient[2] = 1;
        if(temp[4:2]==3'd3) temp[4:2]=3'd0;
        else if (temp[4:2]==3'd4) temp[4:2]=3'd1;
        else if (temp[4:2]==3'd5) temp[4:2]=3'd2;
      end else quotient[2] = 0;
      
      if (temp[3:1] >= 3'd3) begin
        quotient[1] = 1;
        if(temp[3:1]==3'd3) temp[3:1]=3'd0;
        else if (temp[3:1]==3'd4) temp[3:1]=3'd1;
        else if (temp[3:1]==3'd5) temp[3:1]=3'd2;
      end else quotient[1] = 0;
      
      if (temp[2:0] >= 3'd3) begin
        quotient[0] = 1;
        if(temp[2:0]==3'd3) temp[2:0]=3'd0;
        else if (temp[2:0]==3'd4) temp[2:0]=3'd1;
        else if (temp[2:0]==3'd5) temp[2:0]=3'd2;
      end else quotient[0] = 0;
      
      remainder = temp[1:0];
      
    end

endmodule

