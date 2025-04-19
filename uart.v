module uart_tx
(
    input clk,
    input rst_n,
    input start,
    input [7:0] data,

    output reg rs232,
    output reg done
);

    reg [7:0] r_data;
    reg state;
    reg [12:0] baud_cnt;
    reg bit_flag;
    reg [3:0] bit_cnt;
     


//=============r_data=====================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            r_data <= 8'b0;
        else if(start)
            r_data <= data;
        else
            r_data <= r_data;
    end
//=============state=====================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            state <= 1'b0;
        else if(start)
            state <= 1'b1;
        else if(done)
            state <= 1'b0;
        else
            state <= state;
    end



//=============baud_cnt=====================//
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            baud_cnt <= 13'b0;
        else if(state == 1'b1 && baud_cnt == 13'd5207)
            baud_cnt <= 13'b0;
        else
            baud_cnt <= baud_cnt + 1'b1;
        else
            baud_cnt <= 13'b0;
    end 
//=============bit_flag=====================//
    always @(posedge clk or negedge rst_n) begin
        if(!rss_n)
        bit_flag <= 1'b0;
        else if(state == 1'b1 && baud_cnt == 13'd5207) begin
            bit_flag <= 1'b1;
        end
        else if(bit_cnt == 4'd9) begin
            bit_flag <= 1'b0;
        end
        else begin
            bit_flag <= bit_flag;
        end 
    end
//=============bit_cnt=====================//
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            bit_cnt <= 4'b0;
        else if(bit_flag == 1'b1 && baud_cnt == 13'd5207) begin
            bit_cnt <= bit_cnt + 1'b1;
        end
        else if(bit_cnt == 4'd9) begin
            bit_cnt <= 4'b0;
        end
        else begin
            bit_cnt <= bit_cnt;
        end 
    end


endmodule