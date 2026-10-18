
module register_file (
    input clk,
    input reset,
    input reg_write,
    input [2:0] read_addr_a,
    input [2:0] read_addr_b,
    input [2:0] write_addr,
    input [3:0] write_data,
    output [3:0] read_data_a,
    output [3:0] read_data_b
);

reg [3:0] registers [0:7];
integer i;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        for (i = 0; i < 8; i = i + 1)
            registers[i] <= 4'b0000;
    end
    else if (reg_write) begin
        registers[write_addr] <= write_data;
    end
end

assign read_data_a = registers[read_addr_a];
assign read_data_b = registers[read_addr_b];

endmodule
