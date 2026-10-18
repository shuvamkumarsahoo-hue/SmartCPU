
`timescale 1ns/1ps

module alu_tb;

reg [3:0] A, B;
reg [2:0] ALU_Sel;
wire [3:0] Result;
wire Zero, Carry;

alu dut (
    .A(A),
    .B(B),
    .ALU_Sel(ALU_Sel),
    .Result(Result),
    .Zero(Zero),
    .Carry(Carry)
);

initial begin
    $monitor("A=%d B=%d Sel=%b Result=%d Zero=%b Carry=%b",
             A, B, ALU_Sel, Result, Zero, Carry);

    A = 4'd3; B = 4'd2; ALU_Sel = 3'b000; #10;
    A = 4'd5; B = 4'd2; ALU_Sel = 3'b001; #10;
    A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b010; #10;
    A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b011; #10;
    A = 4'b1100; B = 4'b1010; ALU_Sel = 3'b100; #10;
    A = 4'b0101; B = 4'b0000; ALU_Sel = 3'b101; #10;

    $finish;
end

endmodule
