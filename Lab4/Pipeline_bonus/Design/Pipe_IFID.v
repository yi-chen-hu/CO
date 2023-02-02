module Pipe_IFID(clk_i, rst_n, Flush_i, PCadder1_sum_i, Instruction_i, IFIDWrite_i, PCadder1_sum_o, Instruction_o);

input clk_i;
input rst_n;

input Flush_i;
input [15:0] PCadder1_sum_i, Instruction_i;
input IFIDWrite_i;
output reg [15:0] PCadder1_sum_o, Instruction_o;

wire [15:0] PCadder1_sum_comb;
wire [15:0] Instruction_comb;

always@(posedge clk_i)
    if(~rst_n)
        PCadder1_sum_o <= 16'b0;
    else
        PCadder1_sum_o <= PCadder1_sum_comb;
        
assign PCadder1_sum_comb = IFIDWrite_i == 0 ? PCadder1_sum_o : PCadder1_sum_i;

always@(posedge clk_i)
    if(~rst_n)
        Instruction_o <= 16'b0;
    else
        Instruction_o <= Instruction_comb;
        
assign Instruction_comb = Flush_i == 0 ? 16'b0000000000000011 : IFIDWrite_i == 0 ? Instruction_o : Instruction_i;

endmodule