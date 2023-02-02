module Pipe_MEMWB(clk_i, rst_n,
                 RegWrite_i, MemToReg_i,
                 Mem_Readdata_i, FUResult_i, RDaddr_i,
                 RegWrite_o, MemToReg_o,
                 Mem_Readdata_o, FUResult_o, RDaddr_o);

input clk_i;
input rst_n;
input RegWrite_i;
input MemToReg_i;
input [15:0] Mem_Readdata_i, FUResult_i;
input [2:0] RDaddr_i;

output reg RegWrite_o;
output reg MemToReg_o;
output reg [15:0] Mem_Readdata_o, FUResult_o;
output reg [2:0] RDaddr_o;

always@(posedge clk_i)
    if(~rst_n) begin
        RegWrite_o <= 0;
        MemToReg_o <= 0;
        Mem_Readdata_o <= 0;
        FUResult_o <= 0;
        RDaddr_o <= 0;
    end
    else begin
        RegWrite_o <= RegWrite_i;
        MemToReg_o <= MemToReg_i;
        Mem_Readdata_o <= Mem_Readdata_i;
        FUResult_o <= FUResult_i;
        RDaddr_o <= RDaddr_i;
    end
        
endmodule