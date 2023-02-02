module Pipe_IFID(clk_i, rst_n, PCadder1_sum_i, Instruction_i, IFIDWrite_i, PCadder1_sum_o, Instruction_o);

input clk_i;
input rst_n;

input [15:0] PCadder1_sum_i, Instruction_i;
input [1:0] IFIDWrite_i;
output reg [15:0] PCadder1_sum_o, Instruction_o;

wire [15:0] PCadder1_sum_comb;
reg [15:0] Instruction_comb;

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
        
always@(*)
    case(IFIDWrite_i)
        2'b00: Instruction_comb = Instruction_o;
        2'b10: Instruction_comb = 16'b0000000000000011;
        default: Instruction_comb = Instruction_i;
    endcase

endmodule