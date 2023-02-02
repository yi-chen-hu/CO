module Instr_Memory( pc_addr_i, instr_o	);

//I/O ports
input  [16-1:0]  pc_addr_i;
output [16-1:0]	 instr_o;

//Internal Signals
reg    [16-1:0]	 instr_o;
integer          i;

//32 words Memory
reg    [16-1:0]  Instr_Mem [0:16-1];

//Parameter
    
//Main function
always @(pc_addr_i) begin
	instr_o = Instr_Mem[pc_addr_i/2];
end
    
//Initial Memory Contents
initial begin
    for ( i=0; i<16; i=i+1 )
	    Instr_Mem[i] = 16'hFFFF;
end

endmodule
