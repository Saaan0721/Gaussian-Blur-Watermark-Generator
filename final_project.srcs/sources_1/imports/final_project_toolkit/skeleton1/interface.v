
module interface (
    input clk,
    input resetn,
    input [23:0] input_img,
    input HSYNC,
    input VSYNC,    

    output ena,
    output wea,
    output [71:0] addra,
    output [215:0] dina,

    output enb,
    output web,
    output [71:0] addrb,
    output [215:0] dinb
);

    // state register
    reg [8:0] row_count;
    reg [9:0] col_count;

    reg enb;
    reg web;
    reg [71:0] addrb;
    reg [215:0] dinb;
    
    wire [8:0] W_row;
    wire [9:0] W_col;
    
    reg [3:0] row_mod;
    reg [3:0] col_mod;
    reg [7:0] col_div;
    
    wire [7:0] W_col_div;
    
    wire [3:0] W_addr[1:0];
    wire [7:0] W_addr_sum;
    
    wire [8:0] W_data_sum;
    
    adder_9bit adder_9bit_row(.a(row_count), .b(9'b1), .sum(W_row));
    adder_10bit adder_10bit_col(.a(col_count), .b(10'b1), .sum(W_col));
    
    adder_8bit adder_8bit_col_div(.a(col_div), .b(8'b1), .sum(W_col_div));
    
    adder_4bit adder_4bit_col_0(.a(col_mod), .b(row_mod<<1), .sum(W_addr[0]));
    adder_4bit adder_4bit_col_1(.a(W_addr[0]), .b(row_mod), .sum(W_addr[1]));
    assign W_addr_sum = {W_addr[1],3'b0};
    
    adder_9bit adder_9bit_data(.a({1'b0,W_addr_sum}), .b({W_addr_sum,1'b0}), .sum(W_data_sum));
    
    always @(posedge clk or negedge resetn) begin
        if(~resetn) begin
            row_count = 0;
            col_count = 0;
            enb = 0;
            web = 0;
            addrb = 0;
            dinb = 0;
            
            row_mod = 0;
            col_mod = 0;
            col_div = 0;
        end
        else begin
            if(VSYNC & HSYNC) begin
                if(col_count <= 640 && row_count < 480) begin
                    enb = 1'b1;
                    web = (VSYNC & HSYNC);
                    
                    // calculate address
                    addrb = (W_col_div << W_addr_sum);

                    // image data, col_count, row_count
                    dinb = (input_img << W_data_sum);

                    // move to next col
                    col_count = W_col;
                    
                    if(col_mod == 0 ) col_mod=1; 
                    else begin
                        if(col_mod == 1) col_mod=2;
                        else if(col_mod == 2) begin
                            col_mod=0;
                            col_div = W_col_div;
                         end
                     end
                end

                // when col is end, move to next row
                if(col_count == 640) begin
                    col_count = 0;
                    row_count = W_row;
                    col_mod=0;
                    col_div=0;
                    if(row_mod == 0) row_mod=1;
                    else begin
                        if(row_mod == 1) row_mod=2;
                        else if(row_mod == 2) row_mod=0;
                    end
                 end
            end
            else begin
                enb = 1'b0;
                web = 1'b0;
            end
        end
    end

    
endmodule