module MEM_ForwardingUnit(MemToReg_WB_i, MemWrite_MEM_i, RTaddr_WB_i, RTaddr_MEM_i, MEM_Forward_o);

input MemToReg_WB_i, MemWrite_MEM_i;
input [2:0] RTaddr_WB_i, RTaddr_MEM_i;

output reg MEM_Forward_o;

always@(*)
    if(MemToReg_WB_i && MemWrite_MEM_i && RTaddr_WB_i == RTaddr_MEM_i)
        MEM_Forward_o = 1'b1;
    else
        MEM_Forward_o = 1'b0;

endmodule