
`timescale 1ns/1ps

module program_counter_tb;

reg clk, reset, pc_enable, pc_load;
reg [7:0] pc_target;
wire [7:0] pc;

program_counter dut (
    .clk(clk),
    .reset(reset),
    .pc_enable(pc_enable),
    .pc_load(pc_load),
    .pc_target(pc_target),
    .pc(pc)
);

always #5 clk = ~clk;

initial begin
    $monitor("Time=%0t Reset=%b Enable=%b Load=%b Target=%d PC=%d",
             $time, reset, pc_enable, pc_load, pc_target, pc);

    clk = 0;
    reset = 1;
    pc_enable = 0;
    pc_load = 0;
    pc_target = 0;

    #10;
    reset = 0;

    // Increment PC from 0 to 1
    pc_enable = 1;
    #10;

    // Increment PC from 1 to 2
    #10;

    // Jump to address 100
    pc_enable = 0;
    pc_load = 1;
    pc_target = 100;
    #10;

    // Hold at address 100
    pc_load = 0;
    #10;

    if (pc !== 8'd100)
        $display("TEST FAILED");
    else
        $display("TEST PASSED");

    $finish;
end

endmodule
