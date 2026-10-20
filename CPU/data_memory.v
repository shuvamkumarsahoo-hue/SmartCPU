
module data_memory (
    input clk,
    input mem_read,
    input mem_write,
    input [3:0] address,
    input [3:0] write_data,
    output [3:0] read_data
);

reg [3:0] memory [0:15];
integer i;

initial begin
    for (i = 0; i < 16; i = i + 1)
        memory[i] = 4'd0;
end

always @(posedge clk) begin
    if (mem_write)
        memory[address] <= write_data;
end

assign read_data = mem_read ? memory[address] : 4'd0;

endmodule
