`timescale 1ns / 1ps

module final_top_distr(
    input clk,
    input resetn,
    input [23:0] input_img,
    input HSYNC,
    input VSYNC,

    input [8:0] start_row,
    input [9:0] start_col,

    output [23:0] output_img,
    output valid
);

    //Uncomment this to simply pass the image data to output
    
    // always @(posedge clk ) begin
    //     if(HSYNC & VSYNC) begin
    //         valid <= 1'b1;
    //         output_img <= input_img;
    //     end
    //     else begin
    //         valid <= 1'b0;
    //         output_img <= 24'dx;
    //     end

    // end

    block_ram u_block_ram_0(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[7:0]   ),
        .dina  (   ),
        .douta ( mux_data_in[23:0]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[7:0]   ),
        .dinb  ( dinb[23:0]  ),
        .doutb (   )
    );

    block_ram u_block_ram_1(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[15:8]   ),
        .dina  (   ),
        .douta ( mux_data_in[47:24]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[15:8]   ),
        .dinb  ( dinb[47:24]  ),
        .doutb (   )
    );

    block_ram u_block_ram_2(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[23:16]   ),
        .dina  (   ),
        .douta ( mux_data_in[71:48]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[23:16]   ),
        .dinb  ( dinb[71:48]  ),
        .doutb (   )
    );

    block_ram u_block_ram_3(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[31:24]   ),
        .dina  (   ),
        .douta ( mux_data_in[95:72]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[31:24]   ),
        .dinb  ( dinb[95:72]  ),
        .doutb (   )
    );

    block_ram u_block_ram_4(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[39:32]   ),
        .dina  (   ),
        .douta ( mux_data_in[119:96]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[39:32]   ),
        .dinb  ( dinb[119:96]  ),
        .doutb (   )
    );

    block_ram u_block_ram_5(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[47:40]   ),
        .dina  (   ),
        .douta ( mux_data_in[143:120]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[47:40]   ),
        .dinb  ( dinb[143:120]  ),
        .doutb (   )
    );

    block_ram u_block_ram_6(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[55:48]   ),
        .dina  (   ),
        .douta ( mux_data_in[167:144]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[55:48]   ),
        .dinb  ( dinb[167:144]  ),
        .doutb (   )
    );

    block_ram u_block_ram_7(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[63:56]   ),
        .dina  (   ),
        .douta ( mux_data_in[191:168]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[63:56]   ),
        .dinb  ( dinb[191:168]  ),
        .doutb (   )
    );

    block_ram u_block_ram_8(
        .clk   ( clk   ),
        //Read
        .ena   ( 1'b1   ),
        .wea   ( 1'b0   ),
        .addra ( blkram_read_address[71:64]   ),
        .dina  (   ),
        .douta ( mux_data_in[215:192]   ),
        //Write
        .enb   ( enb    ),
        .web   ( web    ),
        .addrb ( addrb[71:64]   ),
        .dinb  ( dinb[215:192]  ),
        .doutb (   )
    );

    interface u_interface(

        // input
        .clk    ( clk   ),
        .resetn ( resetn    ),
        .input_img  ( input_img ),
        .HSYNC  ( HSYNC ),
        .VSYNC  ( VSYNC ),

        // output
        .ena    (   ),
        .wea    (   ),
        .addra  (   ),
        .dina   (   ),
        .enb    ( enb   ),
        .web    ( web   ),
        .addrb  ( addrb ),
        .dinb   ( dinb  )
    );

    control_unit u_control(

        // input
        .clk    ( clk   ),
        .resetn ( resetn    ),
        .HSYNC_in   ( HSYNC_in  ),
        .VSYNC_in   ( VSYNC_in  ),
        .row_in ( row_count_minus_1_2 ),
        .col_in ( col_count_2   ),
        .mux_data_in    ( mux_data_in   ),

        // output
        .HSYNC_out  ( HSYNC_out ),
        .VSYNC_out  ( VSYNC_out ),
        .blkram_read_address    ( blkram_read_address   ),
        .row_out    ( row_out   ),
        .col_out    ( col_out   ),
        .mux_data_out   ( mux_data_out  )
    );

    conv_unit u_conv_unit(

        // input
        .clk    ( clk   ),
        .resetn ( resetn    ),
        .data   ( mux_data_out  ),

        // output
        .pixel_out  ( pixel_out )
    );

    watermark u_watermark(
        .clk    ( clk   ),
        .resetn ( resetn    ),

        // input
        .data   ( pixel_out ),
        .row_idx    ( row_out   ),
        .col_idx    ( col_out   ),
        .HSYNC_in   ( HSYNC_out ),
        .VSYNC_in   ( VSYNC_out ),
        .start_row  ( start_row ),
        .start_col  ( start_col ),

        // output
        .data_out   ( data_out  ),
        .HSYNC_out  ( HSYNC_out_watermark   ),
        .VSYNC_out  ( VSYNC_out_watermark   )
    );

    // state register
    reg [8:0] row_count;
    reg [9:0] col_count;

    reg [8:0] row_count_1;
    reg [9:0] col_count_1;

    reg [8:0] row_count_2;
    reg [9:0] col_count_2;

    reg [8:0] row_count_minus_1;
    reg [8:0] row_count_minus_1_1;
    reg [8:0] row_count_minus_1_2;

    reg [1:0] HSYNC_1;
    reg [1:0] HSYNC_2;

    // interface
    wire enb;
    wire web;
    wire [71:0] addrb;
    wire [215:0] dinb;

    // control
    wire HSYNC_in;
    wire VSYNC_in;
    wire [215:0] mux_data_in;

    wire HSYNC_out;
    wire VSYNC_out;
    wire [71:0] blkram_read_address;
    wire [8:0] row_out;
    wire [9:0] col_out;
    wire [215:0] mux_data_out;

    // assign HSYNC_in = (col_count_2 > 0 && col_count_2 <= 640);
    // assign VSYNC_in = (row_count_2 > 0 && row_count_2 <= 480);

    assign HSYNC_in = (col_count_2 > 0 && col_count_2 <= 640 && HSYNC_2) 
                    || (col_count_2 == 640) || (col_count_2 > 0 && row_count_2 == 480);
    assign VSYNC_in = (row_count_2 > 0 && row_count_2 <= 480) || (row_count_2 == 480);

    // conv_unit
    wire [23:0] pixel_out;

    // watermark
    wire [23:0] data_out;
    wire HSYNC_out_watermark;
    wire VSYNC_out_watermark;

    // output
    reg [23:0] output_img;
    reg valid;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            row_count <= 0;
            col_count <= 0;
            row_count_1 <= 0;
            col_count_1 <= 0;
            row_count_2 <= 0;
            col_count_2 <= 0;
            row_count_minus_1 <= 0;
            row_count_minus_1_1 <= 0;
            row_count_minus_1_2 <= 0;
            HSYNC_1 <= 0;
            HSYNC_2 <= 0;
            output_img <= 0;
            valid <= 0;
        end
        else begin
            col_count_2 <= col_count_1;
            row_count_2 <= row_count_1;
            row_count_minus_1_2 <= row_count_minus_1_1;
            col_count_1 <= col_count;
            row_count_1 <= row_count;
            row_count_minus_1_1 <= row_count_minus_1;

            HSYNC_2 <= HSYNC_1;
            HSYNC_1 <= HSYNC;

            if (HSYNC & VSYNC) begin
                // move to next col
                col_count <= col_count + 1;
            end

            // when col is end, move to next row
            if(col_count == 640) begin
                col_count <= 0;
                row_count_minus_1 <= row_count;
                row_count <= row_count + 1;
            end

            // last row
            if (row_count == 480) begin
                col_count <= col_count + 1;
            end
        end

        if(HSYNC_out_watermark & VSYNC_out_watermark) begin
            valid <= 1'b1;
            output_img <= data_out;
        end
        else begin
            valid <= 1'b0;
            output_img <= 24'dx;
        end
    end    
    

endmodule
