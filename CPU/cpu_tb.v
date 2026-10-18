
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
    $monitor("Time=%0t PC=%0d Instruction=%b Opcode=%b ALU_Result=%0d",
             $time, pc_out, instruction_out,
             instruction_out[11:9], alu_result_out);

    clk = 0;
    reset = 1;

    #12;
    reset = 0;

    // Observe several instruction cycles
    repeat (7) @(posedge clk);

    #1;
    $display("CPU INTEGRATION TEST COMPLETED");
    $finish;
end

endmodule
