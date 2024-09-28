module control_unit (
    input clk, 
    input resetn,

    input HSYNC_in,
    input VSYNC_in,

    input [8:0] row_in,
    input [9:0] col_in,
    input [215:0] mux_data_in,

    output reg HSYNC_out,
    output reg VSYNC_out,

    // initial: wire
    output [71:0] blkram_read_address,

    output reg [8:0] row_out,
    output reg [9:0] col_out,
    output reg [215:0] mux_data_out
);

    reg HSYNC_read;
    reg VSYNC_read;

    reg [8:0] row_read;
    reg [9:0] col_read;
    
    wire [9:0] col_in_add[2:0];
    wire [8:0] col_in_address[2:0];
    
    adder_10bit adder_10bit_in_0(.a(col_in), .b(10'd1), .sum(col_in_add[0]));
    adder_10bit adder_10bit_in_1(.a(col_in), .b(10'd2), .sum(col_in_add[1]));
    adder_10bit adder_10bit_in_2(.a(col_in), .b(10'd3), .sum(col_in_add[2]));
    
    divider_3 divider_3_in_0(.a(col_in_add[0]), .quotient(col_in_address[0]));
    divider_3 divider_3_in_1(.a(col_in_add[1]), .quotient(col_in_address[1]));
    divider_3 divider_3_in_2(.a(col_in_add[2]), .quotient(col_in_address[2]));
    
    
    assign blkram_read_address[7:0] = col_in_address[2][7:0];
    assign blkram_read_address[15:8] = col_in_address[1][7:0];
    assign blkram_read_address[23:16] = col_in_address[0][7:0];
    assign blkram_read_address[31:24] = col_in_address[2][7:0];
    assign blkram_read_address[39:32] = col_in_address[1][7:0];
    assign blkram_read_address[47:40] = col_in_address[0][7:0];
    assign blkram_read_address[55:48] = col_in_address[2][7:0];
    assign blkram_read_address[63:56] = col_in_address[1][7:0];
    assign blkram_read_address[71:64] = col_in_address[0][7:0];
    
    wire [9:0] col_read_sum[1:0];
    wire [1:0] col_read_address[2:0];
    
    adder_10bit adder_10bit_read_0(.a(col_read), .b(10'd1023), .sum(col_read_sum[0]));
    adder_10bit adder_10bit_read_1(.a(col_read), .b(10'd1022), .sum(col_read_sum[1]));
    
    divider_3 divider_3_col_0(.a(col_read), .remainder(col_read_address[0]));
    divider_3 divider_3_col_1(.a(col_read_sum[0]), .remainder(col_read_address[1]));
    divider_3 divider_3_col_2(.a(col_read_sum[1]), .remainder(col_read_address[2]));
    
    wire [8:0] row_read_sum[1:0];
    wire [1:0] row_read_address[2:0];
    
    adder_9bit adder_9bit_read_0(.a(row_read), .b(9'd1), .sum(row_read_sum[0]));
    adder_9bit adder_9bit_read_1(.a(row_read), .b(9'd511), .sum(row_read_sum[1]));
    
    divider_3 divider_3_row_0(.a({1'b0,row_read}), .remainder(row_read_address[0]));
    divider_3 divider_3_row_1(.a({1'b0,row_read_sum[0]}), .remainder(row_read_address[1]));
    divider_3 divider_3_row_2(.a({1'b0,row_read_sum[1]}), .remainder(row_read_address[2]));
    
    
    
    wire [3:0] row_3[2:0];
    adder_4bit adder_4bit_row_0(.a({2'b0,row_read_address[2]}), .b({1'b0,row_read_address[2],1'b0}), .sum(row_3[2]));
    adder_4bit adder_4bit_row_1(.a({2'b0,row_read_address[0]}), .b({1'b0,row_read_address[0],1'b0}), .sum(row_3[1]));
    adder_4bit adder_4bit_row_2(.a({2'b0,row_read_address[1]}), .b({1'b0,row_read_address[1],1'b0}), .sum(row_3[0]));
    
    wire [3:0] mux_add[8:0];
    
    adder_4bit adder_4bit_0(.a({2'b0,col_read_address[2]}), .b(row_3[2]), .sum(mux_add[0]));
    adder_4bit adder_4bit_1(.a({2'b0,col_read_address[1]}), .b(row_3[2]), .sum(mux_add[1]));
    adder_4bit adder_4bit_2(.a({2'b0,col_read_address[0]}), .b(row_3[2]), .sum(mux_add[2]));
    adder_4bit adder_4bit_3(.a({2'b0,col_read_address[2]}), .b(row_3[1]), .sum(mux_add[3]));
    adder_4bit adder_4bit_4(.a({2'b0,col_read_address[1]}), .b(row_3[1]), .sum(mux_add[4]));
    adder_4bit adder_4bit_5(.a({2'b0,col_read_address[0]}), .b(row_3[1]), .sum(mux_add[5]));
    adder_4bit adder_4bit_6(.a({2'b0,col_read_address[2]}), .b(row_3[0]), .sum(mux_add[6]));
    adder_4bit adder_4bit_7(.a({2'b0,col_read_address[1]}), .b(row_3[0]), .sum(mux_add[7]));
    adder_4bit adder_4bit_8(.a({2'b0,col_read_address[0]}), .b(row_3[0]), .sum(mux_add[8]));
    
    wire [6:0] mux_add_8[8:0];
    assign mux_add_8[0] ={mux_add[0],3'b0};
    assign mux_add_8[1] ={mux_add[1],3'b0};
    assign mux_add_8[2] ={mux_add[2],3'b0};
    assign mux_add_8[3] ={mux_add[3],3'b0};
    assign mux_add_8[4] ={mux_add[4],3'b0};
    assign mux_add_8[5] ={mux_add[5],3'b0};
    assign mux_add_8[6] ={mux_add[6],3'b0};
    assign mux_add_8[7] ={mux_add[7],3'b0};
    assign mux_add_8[8] ={mux_add[8],3'b0};
    
    wire [7:0] mux_add_24[8:0];
    adder_8bit adder_8bit_0(.a({1'b0,mux_add_8[0]}), .b({mux_add_8[0],1'b0}), .sum(mux_add_24[0]));
    adder_8bit adder_8bit_1(.a({1'b0,mux_add_8[1]}), .b({mux_add_8[1],1'b0}), .sum(mux_add_24[1]));
    adder_8bit adder_8bit_2(.a({1'b0,mux_add_8[2]}), .b({mux_add_8[2],1'b0}), .sum(mux_add_24[2]));
    adder_8bit adder_8bit_3(.a({1'b0,mux_add_8[3]}), .b({mux_add_8[3],1'b0}), .sum(mux_add_24[3]));
    adder_8bit adder_8bit_4(.a({1'b0,mux_add_8[4]}), .b({mux_add_8[4],1'b0}), .sum(mux_add_24[4]));
    adder_8bit adder_8bit_5(.a({1'b0,mux_add_8[5]}), .b({mux_add_8[5],1'b0}), .sum(mux_add_24[5]));
    adder_8bit adder_8bit_6(.a({1'b0,mux_add_8[6]}), .b({mux_add_8[6],1'b0}), .sum(mux_add_24[6]));
    adder_8bit adder_8bit_7(.a({1'b0,mux_add_8[7]}), .b({mux_add_8[7],1'b0}), .sum(mux_add_24[7]));
    adder_8bit adder_8bit_8(.a({1'b0,mux_add_8[8]}), .b({mux_add_8[8],1'b0}), .sum(mux_add_24[8]));
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            HSYNC_out <= 0;
            VSYNC_out <= 0;
            row_out <= 0;
            col_out <= 0;
            mux_data_out <= 0;
            HSYNC_read <= 0;
            VSYNC_read <= 0;
            row_read <= 0;
            col_read <= 0;
        end
        else begin
            if ((HSYNC_in & VSYNC_in) | (HSYNC_read & VSYNC_read) ) begin

                // 0th pixel
                if (col_read == 1 || row_read == 0) begin
                    mux_data_out[23:0] <= 0;
                end
                else begin
                    mux_data_out[23:0] <= mux_data_in >> mux_add_24[0];
                end

                // 1st pixel
                if (row_read == 0) begin
                    mux_data_out[47:24] <= 0;
                end
                else begin
                    mux_data_out[47:24] <= mux_data_in >> mux_add_24[1];
                end

                // 2nd pixel
                if (col_read == 640 || row_read == 0) begin
                    mux_data_out[71:48] <= 0;
                end
                else begin
                    mux_data_out[71:48] <= mux_data_in >> mux_add_24[2];
                end

                // 3rd pixel
                if (col_read == 1) begin
                    mux_data_out[95:72] <= 0;
                end
                else begin
                    mux_data_out[95:72] <= mux_data_in >> mux_add_24[3];
                end

                // 4th pixel
                mux_data_out[119:96] <= mux_data_in >> mux_add_24[4];

                // 5th pixel
                if (col_read == 640) begin
                    mux_data_out[143:120] <= 0;
                end
                else begin
                    mux_data_out[143:120] <= mux_data_in >> mux_add_24[5];
                end

                // 6th pixel
                if (col_read == 1 || row_read == 479) begin
                    mux_data_out[167:144] <= 0;
                end
                else begin
                    mux_data_out[167:144] <= mux_data_in >> mux_add_24[6];
                end

                // 7th pixel
                if (row_read == 479) begin
                    mux_data_out[191:168] <= 0;
                end
                else begin
                    mux_data_out[191:168] <= mux_data_in >> mux_add_24[7];
                end

                // 8th pixel
                if (col_read == 640 || row_read == 479) begin
                    mux_data_out[215:192] <= 0;
                end
                else begin
                    mux_data_out[215:192] <= mux_data_in >> mux_add_24[8];
                end
            end

            HSYNC_out <= HSYNC_read;
            VSYNC_out <= VSYNC_read;

            HSYNC_read <= HSYNC_in;
            VSYNC_read <= VSYNC_in;
            
            row_out <= row_read;
            col_out <= col_read;

            row_read <= row_in;
            col_read <= col_in;
        end
    end

endmodule