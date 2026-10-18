
`timescale 1ns/1ps

module instruction_memory_tb;

reg [7:0] address;
wire [8:0] instruction;

instruction_memory dut (
    .address(address),
    .instruction(instruction)
);

initial begin
    $monitor("Time=%0t Address=%0d Instruction=%b Opcode=%b Dest=R%0d Source=R%0d",
             $time, address, instruction,
             instruction[8:6],
             instruction[5:3],
             instruction[2:0]);

    address = 0; #10;
    address = 1; #10;
    address = 2; #10;
    address = 3; #10;
    address = 4; #10;

    if (instruction !== {3'b100, 3'd5, 3'd4})
        $display("TEST FAILED");
    else
        $display("TEST PASSED");

    $finish;
end

endmodule
