module Data_Memory(	clk_i, addr_i, data_i, MemRead_i, MemWrite_i, data_o);

// Interface
input				clk_i;
input	[15:0]		addr_i;
input	[15:0]		data_i;
input				MemRead_i;
input				MemWrite_i;
output	[15:0] 		data_o;

// Signals
reg		[15:0]		data_o;

// Memory
reg		[7:0]		Mem 			[0:127];	// address: 0x00~0x80
integer				i;

// For Testbench to debug
wire	[15:0]		memory			[0:63];
assign  memory[0]={Mem[1], Mem[0]};
assign  memory[1]={Mem[3], Mem[2]};
assign  memory[2]={Mem[5], Mem[4]};
assign  memory[3]={Mem[7], Mem[6]};
assign  memory[4]={Mem[9], Mem[8]};
assign  memory[5]={Mem[11], Mem[10]};
assign  memory[6]={Mem[13], Mem[12]};
assign  memory[7]={Mem[15], Mem[14]};
assign  memory[8]={Mem[17], Mem[16]};
assign  memory[9]={Mem[19], Mem[18]};
assign  memory[10]={Mem[21], Mem[20]};
assign  memory[11]={Mem[23], Mem[22]};
assign  memory[12]={Mem[25], Mem[24]};
assign  memory[13]={Mem[27], Mem[26]};
assign  memory[14]={Mem[29], Mem[28]};
assign  memory[15]={Mem[31], Mem[30]};
assign  memory[16]={Mem[33], Mem[32]};
assign  memory[17]={Mem[35], Mem[34]};
assign  memory[18]={Mem[37], Mem[36]};
assign  memory[19]={Mem[39], Mem[38]};
assign  memory[20]={Mem[41], Mem[40]};
assign  memory[21]={Mem[43], Mem[42]};
assign  memory[22]={Mem[45], Mem[44]};
assign  memory[23]={Mem[47], Mem[46]};
assign  memory[24]={Mem[49], Mem[48]};
assign  memory[25]={Mem[51], Mem[50]};
assign  memory[26]={Mem[53], Mem[52]};
assign  memory[27]={Mem[55], Mem[54]};
assign  memory[28]={Mem[57], Mem[56]};
assign  memory[29]={Mem[59], Mem[58]};
assign  memory[30]={Mem[61], Mem[60]};
assign  memory[31]={Mem[63], Mem[62]};
assign  memory[32]={Mem[65], Mem[64]};
assign  memory[33]={Mem[67], Mem[66]};
assign  memory[34]={Mem[69], Mem[68]};
assign  memory[35]={Mem[71], Mem[70]};
assign  memory[36]={Mem[73], Mem[72]};
assign  memory[37]={Mem[75], Mem[74]};
assign  memory[38]={Mem[77], Mem[76]};
assign  memory[39]={Mem[79], Mem[78]};
assign  memory[40]={Mem[81], Mem[80]};
assign  memory[41]={Mem[83], Mem[82]};
assign  memory[42]={Mem[85], Mem[84]};
assign  memory[43]={Mem[87], Mem[86]};
assign  memory[44]={Mem[89], Mem[88]};
assign  memory[45]={Mem[91], Mem[90]};
assign  memory[46]={Mem[93], Mem[92]};
assign  memory[47]={Mem[95], Mem[94]};
assign  memory[48]={Mem[97], Mem[96]};
assign  memory[49]={Mem[99], Mem[98]};
assign  memory[50]={Mem[101], Mem[100]};
assign  memory[51]={Mem[103], Mem[102]};
assign  memory[52]={Mem[105], Mem[104]};
assign  memory[53]={Mem[107], Mem[106]};
assign  memory[54]={Mem[109], Mem[108]};
assign  memory[55]={Mem[111], Mem[110]};
assign  memory[56]={Mem[113], Mem[112]};
assign  memory[57]={Mem[115], Mem[114]};
assign  memory[58]={Mem[117], Mem[116]};
assign  memory[59]={Mem[119], Mem[118]};
assign  memory[60]={Mem[121], Mem[120]};
assign  memory[61]={Mem[123], Mem[122]};
assign  memory[62]={Mem[125], Mem[124]};
assign  memory[63]={Mem[127], Mem[126]};

initial begin
	for(i=0; i<128; i=i+1)
		Mem[i] = 8'b0;
end 

always@(posedge clk_i) begin
    if(MemWrite_i) begin
		Mem[addr_i+1] <= data_i[15:8];
		Mem[addr_i]   <= data_i[7:0];
	end
end

always@(addr_i or MemRead_i) begin
	if(MemRead_i)
		data_o = {Mem[addr_i+1], Mem[addr_i]};
end

endmodule

