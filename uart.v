module uart_tx
(
    input clk,
    input rst_n,
    input start,
    input [7:0] data,

    output reg rs232,
    output reg done
);

    reg [7:0] r_data,
    reg state;
endmodule