module EX_ForwardingUnit(RegWrite_MEM_i, RDaddr_MEM_i, RSaddr_EX_i, RTaddr_EX_i, 
                         RegWrite_WB_i, RDaddr_WB_i,
                         ForwardA_o, ForwardB_o);

input RegWrite_MEM_i, RegWrite_WB_i;
input [2:0] RDaddr_MEM_i, RSaddr_EX_i, RTaddr_EX_i, RDaddr_WB_i;

output reg [1:0] ForwardA_o, ForwardB_o;

always@(*)
    if(RegWrite_MEM_i && RDaddr_MEM_i == RSaddr_EX_i)
        ForwardA_o = 2'b01;
    else if(RegWrite_WB_i && RDaddr_WB_i == RSaddr_EX_i)
        ForwardA_o = 2'b10;
    else
        ForwardA_o = 2'b00;
 
 always@(*)
    if(RegWrite_MEM_i && RDaddr_MEM_i == RTaddr_EX_i)
        ForwardB_o = 2'b01;
    else if(RegWrite_WB_i && RDaddr_WB_i == RTaddr_EX_i)
        ForwardB_o = 2'b10;
    else
        ForwardB_o = 2'b00;   

endmodule
