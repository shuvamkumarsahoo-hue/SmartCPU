
module program_counter (
    input clk,
    input reset,
    input pc_enable,
    input pc_load,
    input [7:0] pc_target,
    output reg [7:0] pc
);

always @(posedge clk or posedge reset) begin
    if (reset)
        pc <= 8'd0;
    else if (pc_load)
        pc <= pc_target;
    else if (pc_enable)
        pc <= pc + 8'd1;
end

endmodule
