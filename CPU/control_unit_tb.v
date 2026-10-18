
`timescale 1ns/1ps

module control_unit_tb;

reg [2:0] opcode;
wire reg_write, alu_src, mem_read, mem_write, branch;
wire [2:0] alu_op;

control_unit dut (
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .alu_op(alu_op)
);

initial begin
    $monitor("Time=%0t Opcode=%b RegWrite=%b ALUSrc=%b MemRead=%b MemWrite=%b Branch=%b ALUOp=%b",
             $time, opcode, reg_write, alu_src, mem_read,
             mem_write, branch, alu_op);

    opcode = 3'b000; #10; // ADD
    opcode = 3'b001; #10; // SUB
    opcode = 3'b010; #10; // AND
    opcode = 3'b011; #10; // OR
    opcode = 3'b100; #10; // XOR
    opcode = 3'b101; #10; // LOAD
    opcode = 3'b110; #10; // STORE
    opcode = 3'b111; #10; // BRANCH

    $display("CONTROL UNIT TEST COMPLETED");
    $finish;
end

endmodule
