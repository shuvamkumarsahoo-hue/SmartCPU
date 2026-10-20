
`timescale 1ns/1ps

module load_store_tb;

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

    // Execute instructions at PC 0 through PC 6
    repeat (8) @(posedge clk);
    #1;

    $display("\n--- LOAD/STORE CHECK ---");
    $display("Memory[3] = %0d", dut.DMEM.memory[3]);
    $display("R1 = %0d", dut.RF.registers[1]);
    $display("R6 = %0d", dut.RF.registers[6]);

    if (dut.DMEM.memory[3] === 4'd6 &&
        dut.RF.registers[6] === 4'd6)
        $display("LOAD/STORE TEST PASSED");
    else
        $display("LOAD/STORE TEST FAILED");

    $finish;
end

endmodule
