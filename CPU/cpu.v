
module cpu (
    input clk,
    input reset,
    output [7:0] pc_out,
    output [11:0] instruction_out,
    output [3:0] alu_result_out
);

wire [7:0] pc;
wire [11:0] instruction;

wire reg_write, alu_src, mem_read, mem_write, branch;
wire [2:0] alu_op;

wire [2:0] opcode;
wire [2:0] dest;
wire [2:0] src_a;
wire [2:0] src_b;

wire [3:0] data_a;
wire [3:0] data_b;
wire [3:0] alu_result;
wire zero, carry;

assign opcode = instruction[11:9];
assign dest   = instruction[8:6];
assign src_a  = instruction[5:3];
assign src_b  = instruction[2:0];

program_counter PC (
    .clk(clk),
    .reset(reset),
    .pc_enable(1'b1),
    .pc_load(1'b0),
    .pc_target(8'b0),
    .pc(pc)
);

instruction_memory IMEM (
    .address(pc),
    .instruction(instruction)
);

control_unit CU (
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .alu_op(alu_op)
);

register_file RF (
    .clk(clk),
    .reset(reset),
    .reg_write(reg_write),
    .read_addr_a(src_a),
    .read_addr_b(src_b),
    .write_addr(dest),
    .write_data(alu_result),
    .read_data_a(data_a),
    .read_data_b(data_b)
);

alu ALU (
    .A(data_a),
    .B(data_b),
    .ALU_Sel(alu_op),
    .Result(alu_result),
    .Zero(zero),
    .Carry(carry)
);

assign pc_out = pc;
assign instruction_out = instruction;
assign alu_result_out = alu_result;

endmodule
