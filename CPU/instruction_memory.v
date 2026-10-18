

module instruction_memory (
    input [7:0] address,
    output reg [11:0] instruction
);

reg [11:0] memory [0:255];
integer i;

initial begin
    for (i = 0; i < 256; i = i + 1)
        memory[i] = 12'b0;

    // Format: opcode (3), destination (3), source A (3), source B (3)
    memory[0] = {3'b000, 3'd1, 3'd0, 3'd0}; // ADD R1 = R0 + R0
    memory[1] = {3'b000, 3'd2, 3'd1, 3'd1}; // ADD R2 = R1 + R1
    memory[2] = {3'b010, 3'd3, 3'd1, 3'd2}; // AND R3 = R1 & R2
    memory[3] = {3'b011, 3'd4, 3'd1, 3'd2}; // OR R4 = R1 | R2
    memory[4] = {3'b100, 3'd5, 3'd1, 3'd2}; // XOR R5 = R1 ^ R2
end

always @(*) begin
    instruction = memory[address];
end

endmodule
