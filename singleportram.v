module singleportram #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 256
)(
    input clk,
    input [ADDR_WIDTH-1:0] addr,
    inout [DATA_WIDTH-1:0] data,
    input cs,
    input we,
    input oe
);
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [DATA_WIDTH-1:0] tmp_data;

    always @(posedge clk) begin
        if (cs && we) begin
            mem[addr] <= data;
        end
    end

    always @(posedge clk) begin
        if (cs && !we) begin
            tmp_data <= mem[addr];
        end
    end

    assign data = (cs && oe && !we) ? tmp_data : {DATA_WIDTH{1'bz}};
endmodule