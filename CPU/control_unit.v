
module control_unit (
    input [2:0] opcode,
    output reg reg_write,
    output reg alu_src,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg [2:0] alu_op
);

always @(*) begin
    // Safe defaults
    reg_write = 0;
    alu_src   = 0;
    mem_read  = 0;
    mem_write = 0;
    branch    = 0;
    alu_op    = 3'b000;

    case (opcode)
        3'b000: begin // ADD
            reg_write = 1;
            alu_op = 3'b000;
        end

        3'b001: begin // SUB
            reg_write = 1;
            alu_op = 3'b001;
        end

        3'b010: begin // AND
            reg_write = 1;
            alu_op = 3'b010;
        end

        3'b011: begin // OR
            reg_write = 1;
            alu_op = 3'b011;
        end

        3'b100: begin // XOR
            reg_write = 1;
            alu_op = 3'b100;
        end

        3'b101: begin // LOAD
            reg_write = 1;
            alu_src = 1;
            mem_read = 1;
        end

        3'b110: begin // STORE
            alu_src = 1;
            mem_write = 1;
        end

        3'b111: begin // BRANCH
            branch = 1;
            alu_op = 3'b001;
        end
    endcase
end

endmodule
