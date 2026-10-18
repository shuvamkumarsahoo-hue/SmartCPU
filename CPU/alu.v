
module alu (
    input  [3:0] A,
    input  [3:0] B,
    input  [2:0] ALU_Sel,
    output reg [3:0] Result,
    output reg       Zero,
    output reg       Carry
);

always @(*) begin
    Result = 4'b0000;
    Carry  = 1'b0;

    case (ALU_Sel)
        3'b000: {Carry, Result} = {1'b0, A} + {1'b0, B};
        3'b001: Result = A - B;
        3'b010: Result = A & B;
        3'b011: Result = A | B;
        3'b100: Result = A ^ B;
        3'b101: Result = ~A;

        default: Result = 4'b0000;
    endcase

    Zero = (Result == 4'b0000);
end

endmodule
