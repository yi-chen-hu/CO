module Pipe_EXMEM(clk_i, rst_n, RTaddr_i, RTaddr_o,
                 RegWrite_i, MemToReg_i, MemWrite_i, MemRead_i,
                 FUResult_i, RTdata_i, RDaddr_i,
                 RegWrite_o, MemToReg_o, MemWrite_o, MemRead_o,
                 FUResult_o, RTdata_o, RDaddr_o);
input clk_i;
input rst_n;   

input [2:0] RTaddr_i;
output reg [2:0] RTaddr_o;           
input RegWrite_i;
input MemToReg_i;
input MemWrite_i;
input MemRead_i;
input [15:0] FUResult_i, RTdata_i;
input [2:0] RDaddr_i;

output reg RegWrite_o;
output reg MemToReg_o;
output reg MemWrite_o;
output reg MemRead_o;
output reg [15:0] FUResult_o, RTdata_o;
output reg [2:0] RDaddr_o;

always@(posedge clk_i)
    if(~rst_n) begin
        RTaddr_o <= 0;
        RegWrite_o <= 0;
        MemToReg_o <= 0;
        MemWrite_o <= 0;
        MemRead_o <= 0;
        FUResult_o <= 0;
        RTdata_o <= 0;
        RDaddr_o <= 0;
     end
     else begin
        RTaddr_o <= RTaddr_i;
        RegWrite_o <= RegWrite_i;
        MemToReg_o <= MemToReg_i;
        MemWrite_o <= MemWrite_i;
        MemRead_o <= MemRead_i;
        FUResult_o <= FUResult_i;
        RTdata_o <= RTdata_i;
        RDaddr_o <= RDaddr_i;
    end
            
endmodule