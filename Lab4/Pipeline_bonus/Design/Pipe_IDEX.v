module Pipe_IDEX(clk_i, rst_n, Flush_i, IDEXWrite_i, RSaddr_i, RSaddr_o,
                 RegWrite_i, ALUOp_i, ALUSrc_i, RegDst_i, Branch_i, BranchType_i, MemToReg_i, MemRead_i, MemWrite_i, Jump_i,
                 Instr_i, PCadder1_sum_i, RSdata_i, RTdata_i, SignExtend_i, ZeroFilled_i, funct_i, RTaddr_i, RDaddr_i,
                 RegWrite_o, ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, BranchType_o, MemToReg_o, MemRead_o, MemWrite_o, Jump_o,
                 Instr_o, PCadder1_sum_o, RSdata_o, RTdata_o, SignExtend_o, ZeroFilled_o, funct_o, RTaddr_o, RDaddr_o);
input clk_i;
input rst_n;

input [2:0] RSaddr_i;
output reg [2:0] RSaddr_o;

input Flush_i;
input IDEXWrite_i;
input RegWrite_i;
input [2-1:0] ALUOp_i;
input ALUSrc_i;
input RegDst_i;
input Branch_i;
input BranchType_i;
input MemToReg_i;
input MemRead_i;
input MemWrite_i; 
input Jump_i;
input [12:0] Instr_i;
input [15:0] PCadder1_sum_i;
input [15:0] RSdata_i, RTdata_i, SignExtend_i, ZeroFilled_i;
input [3:0] funct_i;
input [2:0] RTaddr_i, RDaddr_i;

output reg RegWrite_o;
output reg [2-1:0] ALUOp_o;
output reg ALUSrc_o;
output reg RegDst_o;
output reg Branch_o;
output reg BranchType_o;
output reg MemToReg_o;
output reg MemRead_o;
output reg MemWrite_o; 
output reg Jump_o;
output reg [12:0] Instr_o;
output reg [15:0] PCadder1_sum_o;
output reg [15:0] RSdata_o, RTdata_o, SignExtend_o, ZeroFilled_o;
output reg [3:0] funct_o;
output reg [2:0] RTaddr_o, RDaddr_o;

reg RegWrite_comb;
reg [2-1:0] ALUOp_comb;
reg ALUSrc_comb;
reg RegDst_comb;
reg Branch_comb;
reg BranchType_comb;
reg MemToReg_comb;
reg MemRead_comb;
reg MemWrite_comb; 
reg Jump_comb;

always@(posedge clk_i)
    if(~rst_n) begin
        RSaddr_o <= 0;
        RegWrite_o <= 0;
        ALUOp_o <= 0;
        ALUSrc_o <= 0;
        RegDst_o <= 0;
        Branch_o <= 0;
        BranchType_o <= 0;
        MemToReg_o <= 0;
        MemRead_o <= 0;
        MemWrite_o <= 0; 
        Jump_o <= 0;
        Instr_o <= 0;
        PCadder1_sum_o <= 0;
        RSdata_o <= 0;
        RTdata_o <= 0;
        SignExtend_o <= 0;
        ZeroFilled_o <= 0;
        funct_o <= 0;
        RTaddr_o <= 0;
        RDaddr_o <= 0;
    end
    else begin
        RSaddr_o <= RSaddr_i;
        RegWrite_o <= RegWrite_comb;
        ALUOp_o <= ALUOp_comb;
        ALUSrc_o <= ALUSrc_comb;
        RegDst_o <= RegDst_comb;
        Branch_o <= Branch_comb;
        BranchType_o <= BranchType_comb;
        MemToReg_o <= MemToReg_comb;
        MemRead_o <= MemRead_comb;
        MemWrite_o <= MemWrite_comb; 
        Jump_o <= Jump_comb;
        Instr_o <= Instr_i;
        PCadder1_sum_o <= PCadder1_sum_i;
        RSdata_o <= RSdata_i;
        RTdata_o <= RTdata_i;
        SignExtend_o <= SignExtend_i;
        ZeroFilled_o <= ZeroFilled_i;
        funct_o <= funct_i;
        RTaddr_o <= RTaddr_i;
        RDaddr_o <= RDaddr_i;
     end
     
always@(*)
    if(IDEXWrite_i == 0 || Flush_i == 0) begin
        RegWrite_comb = 0;
        ALUOp_comb = 0;
        ALUSrc_comb = 0;
        RegDst_comb = 0;
        Branch_comb = 0;
        BranchType_comb = 0;
        MemToReg_comb = 0;
        MemRead_comb = 0;
        MemWrite_comb = 0; 
        Jump_comb = 0;
    end
    else begin
        RegWrite_comb = RegWrite_i;
        ALUOp_comb = ALUOp_i;
        ALUSrc_comb = ALUSrc_i;
        RegDst_comb = RegDst_i;
        Branch_comb = Branch_i;
        BranchType_comb = BranchType_i;
        MemToReg_comb = MemToReg_i;
        MemRead_comb = MemRead_i;
        MemWrite_comb = MemWrite_i; 
        Jump_comb = Jump_i;
    end

endmodule