
`timescale 1ns/1ps

module cpu_tb;

reg clk;
reg reset;

wire [7:0] pc_out;
wire [11:0] instruction_out;
wire [3:0] alu_result_out;

cpu dut (
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out),
    .instruction_out(instruction_out),
    .alu_result_out(alu_result_out)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #12;
    reset = 0;

    // Allow the five instructions to execute
    repeat (6) @(posedge clk);
    #1;

    $display("\n--- REGISTER WRITE-BACK CHECK ---");
    $display("R0 = %0d", dut.RF.registers[0]);
    $display("R1 = %0d", dut.RF.registers[1]);
    $display("R2 = %0d", dut.RF.registers[2]);
    $display("R3 = %0d", dut.RF.registers[3]);
    $display("R4 = %0d", dut.RF.registers[4]);
    $display("R5 = %0d", dut.RF.registers[5]);

    if (dut.RF.registers[0] !== 4'd3 ||
        dut.RF.registers[1] !== 4'd6 ||
        dut.RF.registers[2] !== 4'd12 ||
        dut.RF.registers[3] !== 4'd4 ||
        dut.RF.registers[4] !== 4'd14 ||
        dut.RF.registers[5] !== 4'd10)
        $display("REGISTER WRITE-BACK TEST FAILED");
    else
        $display("REGISTER WRITE-BACK TEST PASSED");

    $finish;
end

endmodule

