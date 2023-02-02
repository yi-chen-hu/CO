module HazardDetector(PCSrc_i, Jump_i, Flush_o);

input PCSrc_i, Jump_i;
output reg Flush_o;

always@(*)
    if(PCSrc_i || Jump_i)
        Flush_o = 1'b0;
    else
        Flush_o = 1'b1;
        
endmodule
