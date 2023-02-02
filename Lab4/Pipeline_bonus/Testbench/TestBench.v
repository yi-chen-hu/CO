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
`define END_COUNT 200		

module TestBench;

//Internal Signals
reg         CLK;
reg         RST;
integer     count;


//Greate tested modle  
Pipeline_CPU cpu(
        .clk_i(CLK),
	    .rst_n(RST)
		);

//Main function

always #(`CYCLE_TIME/2) CLK = ~CLK;	

initial  begin

$readmemb("CO_Lab4_testdata2.txt", cpu.IM.Instr_Mem);
    
	CLK = 0;
	RST = 0;
	count = 0;
    
    #(`CYCLE_TIME)      RST = 1;
    #(`CYCLE_TIME*40)      $stop;

end


always@(posedge CLK) begin
    count = count + 1;
	if( count == 35 ) begin 
        //print result to transcript 
        $display("Register===========================================================\n");
        $display("r0=%0d, r1=%0d, r2=%0d, r3=%0d, r4=%0d, r5=%0d, r6=%0d, r7=%0d\n",
        cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4], 
        cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7],
        );
        
        
        
        $display("\nMemory===========================================================\n");
        $display("m0=%0d, m1=%0d, m2=%0d, m3=%0d, m4=%0d, m5=%0d, m6=%0d, m7=%0d\n\nm8=%0d, m9=%0d, m10=%0d, m11=%0d, m12=%0d, m13=%0d, m14=%0d, m15=%0d\n\nm16=%0d, m17=%0d, m18=%0d, m19=%0d, m20=%0d, m21=%0d, m22=%0d, m23=%0d\n\nm24=%0d, m25=%0d, m26=%0d, m27=%0d, m28=%0d, m29=%0d, m30=%0d, m31=%0d\n",
                  cpu.DM.memory[0], cpu.DM.memory[1], cpu.DM.memory[2], cpu.DM.memory[3],
                     cpu.DM.memory[4], cpu.DM.memory[5], cpu.DM.memory[6], cpu.DM.memory[7],
                     cpu.DM.memory[8], cpu.DM.memory[9], cpu.DM.memory[10], cpu.DM.memory[11],
                     cpu.DM.memory[12], cpu.DM.memory[13], cpu.DM.memory[14], cpu.DM.memory[15],
                     cpu.DM.memory[16], cpu.DM.memory[17], cpu.DM.memory[18], cpu.DM.memory[19], 
                     cpu.DM.memory[20], cpu.DM.memory[21], cpu.DM.memory[22], cpu.DM.memory[23],
                     cpu.DM.memory[24], cpu.DM.memory[25], cpu.DM.memory[26], cpu.DM.memory[27], 
                     cpu.DM.memory[28], cpu.DM.memory[28], cpu.DM.memory[30], cpu.DM.memory[31],
                  );
                  
	end
	else ;
end
  
endmodule



