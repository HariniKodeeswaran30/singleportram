module singleportram_tb;
    parameter ADDR_WIDTH = 8;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 256;

    reg clk;
    reg cs;
    reg we;
    reg oe;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data;

    // Tristate control for data
    assign data = (cs && we) ? data_in : {DATA_WIDTH{1'bz}};

    // Instantiate the DUT
    singleportram #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH)
    ) uut (
        .clk(clk),
        .addr(addr),
        .data(data),
        .cs(cs),
        .we(we),
        .oe(oe)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench logic
    initial begin
        clk = 0;
        cs = 0;
        we = 0;
        oe = 0;
        addr = 0;
        data_in = 0;

        // Write operation
        #10 cs = 1; we = 1; oe = 0; addr = 8'h01; data_in = 8'hA5;

        // Turn off write
        #10 cs = 0; we = 0; oe = 0; data_in = 8'h00;

        // Read operation
        #10 cs = 1; we = 0; oe = 1; addr = 8'h01;

        // Turn off read
        #10 cs = 0; oe = 0;

        #10 $finish;
    end
endmodule
