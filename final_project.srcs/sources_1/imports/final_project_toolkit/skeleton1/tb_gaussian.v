`timescale 1ns / 1ps
//Raw image VGA feeder testbench
module tb_gaussian();

    parameter WIDTH=640;
    parameter HEIGHT=480;

    reg clk = 1'b0;
    reg resetn = 1'b0;
    reg HSYNC_in = 1'b0;
    reg VSYNC_in = 1'b0;
    reg [15:0] resetn_count = 16'd0;
    reg [23:0] input_img;

    wire valid;
    wire [23:0] output_img;

    final_top_distr FINAL_MODULE(
        .clk(clk),
        .resetn(resetn),
        .HSYNC(VSYNC_in),
        .VSYNC(HSYNC_in),
        .input_img(input_img),
        .start_row(9'd450),
        .start_col(10'd630),

        .output_img(output_img),
        .valid(valid)
    );

    //Internal signals...
    reg [15:0] row_count;
    reg [15:0] col_count;

    integer fd, fo;
    integer file_ret;
    integer fo_idx;

    initial begin
        fd = $fopen("stupid_cat.jpg.bin", "rb");
        fo = $fopen("stupid_cat.jpg.bin.out", "wb");
    end

    //Clock generation
    always begin
        #50 clk = ~clk;
    end

    //reset for 50 clock cycles
    always @(posedge clk) begin
        if(resetn_count < 16'd50)
            resetn_count = resetn_count + 1;
        else begin
            resetn = 1'b1;
        end
    end

    //Feed our image data to module with VGA format
    initial begin
        #5025;
        forever begin
            if(~resetn) begin
                col_count = 0;
                row_count = 0;
            end
            else begin
                //VSYNC & HSYNC generation
                if(col_count < 640 && row_count < 480) begin
                    col_count = col_count + 1;
                    HSYNC_in = 1'b1;
                end
                else if (col_count == 799) begin
                    col_count = 0;
                    row_count = row_count + 1;
                    HSYNC_in = 1'b0;
                end
                else if (col_count >= 640) begin
                    col_count = col_count + 1;
                    HSYNC_in = 1'b0;
                end
                if (row_count < 480) begin
                    VSYNC_in = 1'b1;
                end
                else if (row_count >= 480) begin
                    VSYNC_in = 1'b0;
                end
                //Read file and feed data to module
                if(HSYNC_in && VSYNC_in) begin
                    file_ret = $fread(input_img, fd);
                end              
                
            end
            #100;
            //  HSYNC_in = 0;
            //  VSYNC_in = 0;
            //  #200;
        end
    end
   
    reg [23:0] output_img_save;
    reg valid_save;
    reg valid_delay;
    always @(*) begin
        valid_delay = #5 valid;
    end

    //Save Image to file
    always @(posedge clk ) begin
        if (~resetn) begin
            fo_idx <= 0;
        end
        else begin
            if(fo_idx == 640*480) begin
                $fclose(fd);
                $fclose(fo);
                $stop;   //End of one image!!
            end

            if (valid_delay) begin
                //Write module outputs
                fo_idx <= fo_idx + 1;
                
                
                $fwrite(fo,"%c", output_img[23:16]);
                $fwrite(fo,"%c", output_img[15:8]);
                $fwrite(fo,"%c", output_img[7:0]);
            end
        end
        
    end

endmodule
