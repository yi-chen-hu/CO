module Load_Use_HazardDetector(MemRead_EX_i, MemWrite_ID_i,  RTaddr_EX_i, RSaddr_ID_i, RTaddr_ID_i, Write_o);

input MemRead_EX_i, MemWrite_ID_i; 
input [2:0] RTaddr_EX_i, RSaddr_ID_i, RTaddr_ID_i;
output reg Write_o;

always@(*)
    if(MemRead_EX_i && (RTaddr_EX_i == RSaddr_ID_i || RTaddr_EX_i == RTaddr_ID_i))
        if(MemWrite_ID_i && RTaddr_EX_i == RTaddr_ID_i)
            Write_o = 1'b1;
        else
            Write_o = 1'b0;
    else
        Write_o = 1'b1;

endmodule