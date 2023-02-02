//Subject:     CO project 3 - Test Bench
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`timescale 1ns / 1ps
`define CYCLE_TIME 10
`define END_COUNT 50		

module TestBench;

//Internal Signals
reg         CLK;
reg         RST;
integer     count;
integer     i;
integer     handle;

//Greate tested modle  
Simple_Single_CPU cpu(
        .clk_i(CLK),
	    .rst_n(RST)
		);
 
//Main function

always #(`CYCLE_TIME/2) CLK = ~CLK;	

initial  begin
	$readmemb("CO_Lab3_testdata2.txt", cpu.IM.Instr_Mem); 
    handle = $fopen("CO_Lab3_result.txt");

	CLK = 0;
	RST = 0;
	count = 0;

    #(`CYCLE_TIME)      RST = 1;
    #(`CYCLE_TIME*`END_COUNT)      $stop;
end


always@(posedge CLK) begin
	if( count == `END_COUNT) begin 
	//print result to transcript 
	$display("Register======================================================");
	$display(
"r0=%d  r1=%d  r2=%d  r3=%d\n\
r4=%d  r5=%d  r6=%d  r7=%d\n",
cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3],
cpu.RF.Reg_File[4], cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7],
);
	
	$display("Memory========================================================");
	$display(
" m0=%d   m1=%d   m2=%d   m3=%d\n\
 m4=%d   m5=%d   m6=%d   m7=%d\n\
 m8=%d   m9=%d  m10=%d  m11=%d\n\
m12=%d  m13=%d  m14=%d  m15=%d\n\
m16=%d  m17=%d  m18=%d  m19=%d\n\
m20=%d  m21=%d  m22=%d  m23=%d\n\
m24=%d  m25=%d  m26=%d  m27=%d\n\
m28=%d  m29=%d  m30=%d  m31=%d\n",
cpu.DM.memory[0], cpu.DM.memory[1], cpu.DM.memory[2], cpu.DM.memory[3], cpu.DM.memory[4], 
cpu.DM.memory[5], cpu.DM.memory[6], cpu.DM.memory[7], cpu.DM.memory[8], cpu.DM.memory[9], 
cpu.DM.memory[10],cpu.DM.memory[11], cpu.DM.memory[12], cpu.DM.memory[13], cpu.DM.memory[14],
cpu.DM.memory[15], cpu.DM.memory[16], cpu.DM.memory[17], cpu.DM.memory[18], cpu.DM.memory[19], 
cpu.DM.memory[20], cpu.DM.memory[21], cpu.DM.memory[22], cpu.DM.memory[23], cpu.DM.memory[24], 
cpu.DM.memory[25],cpu.DM.memory[26], cpu.DM.memory[27], cpu.DM.memory[28], cpu.DM.memory[29],
cpu.DM.memory[30],cpu.DM.memory[31]
);
$fdisplay(handle, "Register======================================================");
$fdisplay(handle, 
"r0=%d  r1=%d  r2=%d  r3=%d\n\
r4=%d  r5=%d  r6=%d  r7=%d\n",
cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3],
cpu.RF.Reg_File[4], cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7],
);
	
$fdisplay(handle, "Memory========================================================");
$fdisplay(handle, 
" m0=%d   m1=%d   m2=%d   m3=%d\n\
 m4=%d   m5=%d   m6=%d   m7=%d\n\
 m8=%d   m9=%d  m10=%d  m11=%d\n\
m12=%d  m13=%d  m14=%d  m15=%d\n\
m16=%d  m17=%d  m18=%d  m19=%d\n\
m20=%d  m21=%d  m22=%d  m23=%d\n\
m24=%d  m25=%d  m26=%d  m27=%d\n\
m28=%d  m29=%d  m30=%d  m31=%d\n",
cpu.DM.memory[0], cpu.DM.memory[1], cpu.DM.memory[2], cpu.DM.memory[3], cpu.DM.memory[4], 
cpu.DM.memory[5], cpu.DM.memory[6], cpu.DM.memory[7], cpu.DM.memory[8], cpu.DM.memory[9], 
cpu.DM.memory[10],cpu.DM.memory[11], cpu.DM.memory[12], cpu.DM.memory[13], cpu.DM.memory[14],
cpu.DM.memory[15], cpu.DM.memory[16], cpu.DM.memory[17], cpu.DM.memory[18], cpu.DM.memory[19], 
cpu.DM.memory[20], cpu.DM.memory[21], cpu.DM.memory[22], cpu.DM.memory[23], cpu.DM.memory[24], 
cpu.DM.memory[25],cpu.DM.memory[26], cpu.DM.memory[27], cpu.DM.memory[28], cpu.DM.memory[29],
cpu.DM.memory[30],cpu.DM.memory[31]
);
$finish;
	end
	else begin
		if(cpu.IM.Instr_Mem[ cpu.PC.pc_out_o>>1 ] == 16'hFFFF)begin
			count = `END_COUNT;
			#(`CYCLE_TIME*2);
		end 
		else 
    	count = count + 1;
	end
end
  
endmodule

