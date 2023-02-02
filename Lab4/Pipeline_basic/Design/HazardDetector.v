module HazardDetector(PC_out_i, IDRs_i, IDRt_i, EXRd_i, MEMRd_i,
                      PCSrc_i, Jump_i, MemWrite_EX, RegWrite_EX, MemWrite_MEM, RegWrite_MEM, 
                      Write_o);

input [15:0] PC_out_i;
input [2:0] IDRs_i, IDRt_i, EXRd_i, MEMRd_i;
input PCSrc_i, Jump_i;
input MemWrite_EX, RegWrite_EX;
input MemWrite_MEM, RegWrite_MEM;
output reg [1:0] Write_o;

always@(*)
    if(PC_out_i >= 4 && (EXRd_i == IDRs_i || EXRd_i == IDRt_i) && (MemWrite_EX || RegWrite_EX))
        Write_o = 2'b00;
    else if(PC_out_i >= 4 && (MEMRd_i == IDRs_i || MEMRd_i == IDRt_i) && (MemWrite_MEM || RegWrite_MEM))
        Write_o = 2'b00;
    else if(PC_out_i >= 4 && (PCSrc_i | Jump_i))
        Write_o = 2'b10;
    else
        Write_o = 2'b11;

endmodule