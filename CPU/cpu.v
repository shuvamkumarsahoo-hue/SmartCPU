
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

wire [2:0] opcode, dest, src_a, src_b;
wire [3:0] data_a, data_b;
wire [3:0] alu_result, memory_data, write_back_data;
wire [3:0] memory_address;
wire zero, carry;

assign opcode = instruction[11:9];
assign dest   = instruction[8:6];
assign src_a  = instruction[5:3];
assign src_b  = instruction[2:0];

// Arithmetic instructions use the original register fields.
// LOAD/STORE use [8:6] as the register and [3:0] as address.
assign memory_address = instruction[3:0];

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

// For STORE, [8:6] identifies the source register.
// For LOAD, [8:6] identifies the destination register.
register_file RF (
    .clk(clk),
    .reset(reset),
    .reg_write(mem_read ? 1'b1 : reg_write),
    .read_addr_a(mem_write ? dest : src_a),
    .read_addr_b(src_b),
    .write_addr(dest),
    .write_data(write_back_data),
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

data_memory DMEM (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(memory_address),
    .write_data(data_a),
    .read_data(memory_data)
);

assign write_back_data = mem_read ? memory_data : alu_result;

assign pc_out = pc;
assign instruction_out = instruction;
assign alu_result_out = alu_result;

endmodule
