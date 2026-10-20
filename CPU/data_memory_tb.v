
`timescale 1ns/1ps

module data_memory_tb;

reg clk;
reg mem_read, mem_write;
reg [3:0] address;
reg [3:0] write_data;
wire [3:0] read_data;

data_memory dut (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(address),
    .write_data(write_data),
    .read_data(read_data)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    mem_read = 0;
    mem_write = 0;
    address = 0;
    write_data = 0;

    // Write 9 to address 3
    @(negedge clk);
    address = 4'd3;
    write_data = 4'd9;
    mem_write = 1;

    @(negedge clk);
    mem_write = 0;
    mem_read = 1;
    #1;

    $display("Memory[3] = %0d (expected 9)", read_data);
    if (read_data !== 4'd9)
        $display("TEST 1 FAILED");
    else
        $display("TEST 1 PASSED");

    // Write 6 to address 7
    @(negedge clk);
    mem_read = 0;
    address = 4'd7;
    write_data = 4'd6;
    mem_write = 1;

    @(negedge clk);
    mem_write = 0;
    mem_read = 1;
    #1;

    $display("Memory[7] = %0d (expected 6)", read_data);
    if (read_data !== 4'd6)
        $display("TEST 2 FAILED");
    else
        $display("TEST 2 PASSED");

    $finish;
end

endmodule
