module conv_unit (
    input clk,
    input resetn,

    input [24*9-1:0] data,
    
    output [23:0] pixel_out
    );

    wire [11:0] red;
    wire [11:0] green;
    wire [11:0] blue;
    
    wire [11:0] sum1 [7:0];
    wire [11:0] sum2 [7:0];
    wire [11:0] sum3 [7:0];
    //blue
    wire [11:0] W_blue [8:0];
    
    assign W_blue[0]={4'b0,data[7:0]};
    assign W_blue[1]={3'b0,data[31:24],1'b0};
    assign W_blue[2]={4'b0,data[55:48]};
    assign W_blue[3]={3'b0,data[79:72],1'b0};
    assign W_blue[4]={2'b0,data[103:96],2'b0};
    assign W_blue[5]={3'b0,data[127:120],1'b0};
    assign W_blue[6]={4'b0,data[151:144]};
    assign W_blue[7]={3'b0,data[175:168],1'b0};
    assign W_blue[8]={4'b0,data[199:192]};

    adder_12bit adder_12bit_blue_0 (W_blue[0],W_blue[1],sum1[0]);
    adder_12bit adder_12bit_blue_1 (W_blue[2],W_blue[3],sum1[1]);
    adder_12bit adder_12bit_blue_2 (W_blue[4],W_blue[5],sum1[2]);
    adder_12bit adder_12bit_blue_3 (W_blue[6],W_blue[7],sum1[3]);
    adder_12bit adder_12bit_blue_4 (sum1[0],sum1[1],sum1[4]);
    adder_12bit adder_12bit_blue_5 (sum1[2],sum1[3],sum1[5]);
    adder_12bit adder_12bit_blue_6 (sum1[4],sum1[5],sum1[6]);
    adder_12bit adder_12bit_blue_7 (sum1[6],W_blue[8],sum1[7]);
    
    assign blue = (sum1[7]>>4);
    //green
    wire [11:0] W_green [8:0];
    
    assign W_green[0]={4'b0,data[15:8]};
    assign W_green[1]={3'b0,data[39:32],1'b0};
    assign W_green[2]={4'b0,data[63:56]};
    assign W_green[3]={3'b0,data[87:80],1'b0};
    assign W_green[4]={2'b0,data[111:104],2'b0};
    assign W_green[5]={3'b0,data[135:128],1'b0};
    assign W_green[6]={4'b0,data[159:152]};
    assign W_green[7]={3'b0,data[183:176],1'b0};
    assign W_green[8]={4'b0,data[207:200]};

    adder_12bit adder_12bit_green_0 (W_green[0],W_green[1],sum2[0]);
    adder_12bit adder_12bit_green_1 (W_green[2],W_green[3],sum2[1]);
    adder_12bit adder_12bit_green_2 (W_green[4],W_green[5],sum2[2]);
    adder_12bit adder_12bit_green_3 (W_green[6],W_green[7],sum2[3]);
    adder_12bit adder_12bit_green_4 (sum2[0],sum2[1],sum2[4]);
    adder_12bit adder_12bit_green_5 (sum2[2],sum2[3],sum2[5]);
    adder_12bit adder_12bit_green_6 (sum2[4],sum2[5],sum2[6]);
    adder_12bit adder_12bit_green_7 (sum2[6],W_green[8],sum2[7]);
    
    assign green = (sum2[7]>>4);
    //red
    wire [11:0] W_red [8:0];
    
    assign W_red[0]={4'b0,data[23:16]};
    assign W_red[1]={3'b0,data[47:40],1'b0};
    assign W_red[2]={4'b0,data[71:64]};
    assign W_red[3]={3'b0,data[95:88],1'b0};
    assign W_red[4]={2'b0,data[119:112],2'b0};
    assign W_red[5]={3'b0,data[143:136],1'b0};
    assign W_red[6]={4'b0,data[167:160]};
    assign W_red[7]={3'b0,data[191:184],1'b0};
    assign W_red[8]={4'b0,data[215:208]};

    adder_12bit adder_12bit_red_0 (W_red[0],W_red[1],sum3[0]);
    adder_12bit adder_12bit_red_1 (W_red[2],W_red[3],sum3[1]);
    adder_12bit adder_12bit_red_2 (W_red[4],W_red[5],sum3[2]);
    adder_12bit adder_12bit_red_3 (W_red[6],W_red[7],sum3[3]);
    adder_12bit adder_12bit_red_4 (sum3[0],sum3[1],sum3[4]);
    adder_12bit adder_12bit_red_5 (sum3[2],sum3[3],sum3[5]);
    adder_12bit adder_12bit_red_6 (sum3[4],sum3[5],sum3[6]);
    adder_12bit adder_12bit_red_7 (sum3[6],W_red[8],sum3[7]);
    
    assign red = (sum3[7]>>4);
    
/*    assign red = (data[24*1-1:24*0+16]
                + (data[24*2-1:24*1+16] << 1)
                + data[24*3-1:24*2+16]
                + (data[24*4-1:24*3+16] << 1)
                + (data[24*5-1:24*4+16] << 2)
                + (data[24*6-1:24*5+16] << 1)
                + data[24*7-1:24*6+16]
                + (data[24*8-1:24*7+16] << 1)
                + data[24*9-1:24*8+16]) >> 4;*/

/*    assign green = (data[24*1-1-8:24*0+8]
                + (data[24*2-1-8:24*1+8] << 1)
                + data[24*3-1-8:24*2+8]
                + (data[24*4-1-8:24*3+8] << 1)
                + (data[24*5-1-8:24*4+8] << 2)
                + (data[24*6-1-8:24*5+8] << 1)
                + data[24*7-1-8:24*6+8]
                + (data[24*8-1-8:24*7+8] << 1)
                + data[24*9-1-8:24*8+8]) >> 4;*/

/*    assign blue = (data[24*1-1-16:24*0]
                + (data[24*2-1-16:24*1] << 1)
                + data[24*3-1-16:24*2]
                + (data[24*4-1-16:24*3] << 1)
                + (data[24*5-1-16:24*4] << 2)
                + (data[24*6-1-16:24*5] << 1)
                + data[24*7-1-16:24*6]
                + (data[24*8-1-16:24*7] << 1)
                + data[24*9-1-16:24*8]) >> 4;*/

    assign pixel_out[23:16] = red[7:0];
    assign pixel_out[15:8] = green[7:0];
    assign pixel_out[7:0] = blue[7:0];
    
endmodule