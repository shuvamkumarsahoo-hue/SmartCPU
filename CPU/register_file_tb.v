
`timescale 1ns/1ps

module register_file_tb;

reg clk, reset, reg_write;
reg [2:0] read_addr_a, read_addr_b, write_addr;
reg [3:0] write_data;

wire [3:0] read_data_a, read_data_b;

register_file dut (
    .clk(clk),
    .reset(reset),
    .reg_write(reg_write),
    .read_addr_a(read_addr_a),
    .read_addr_b(read_addr_b),
    .write_addr(write_addr),
    .write_data(write_data),
    .read_data_a(read_data_a),
    .read_data_b(read_data_b)
);

always #5 clk = ~clk;

initial begin
    $monitor("Time=%0t Reset=%b Write=%b AddrA=%d DataA=%d AddrB=%d DataB=%d",
             $time, reset, reg_write, read_addr_a, read_data_a,
             read_addr_b, read_data_b);

    clk = 0;
    reset = 1;
    reg_write = 0;
    read_addr_a = 0;
    read_addr_b = 0;
    write_addr = 0;
    write_data = 0;

    #10;
    reset = 0;

    // Write 5 into register 1
    write_addr = 1;
    write_data = 5;
    reg_write = 1;
    #10;

    // Write 9 into register 2
    write_addr = 2;
    write_data = 9;
    #10;

    // Read registers 1 and 2
    reg_write = 0;
    read_addr_a = 1;
    read_addr_b = 2;
    #10;

    // Verify values
    if (read_data_a !== 4'd5 || read_data_b !== 4'd9)
        $display("TEST FAILED");
    else
        $display("TEST PASSED");

    $finish;
end

endmodule
