module Pipeline_CPU( clk_i, rst_n );
		
//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [16-1:0] PC_in;
wire [16-1:0] PC_ReadAddress;
wire [16-1:0] PCadder1_sum;
wire [16-1:0] PCadder2_sum;
wire [16-1:0] Instruction;
wire  [3-1:0] RDaddr;
wire [16-1:0] RDdata;
wire [16-1:0] RSdata;
wire [16-1:0] RTdata;

//Decoder
wire 	        RegDst;
wire 		RegWrite;
wire	[2-1:0] ALUOp;
wire	        ALUSrc;
wire	        Branch;
wire		MemtoReg;
wire		BranchType;
wire		Jump;
wire		MemRead;
wire		MemWrite;

//AC
wire  [4-1:0] ALU_operation;
wire  [2-1:0] FUResult_Select;
wire [16-1:0] FUResult;

//ALU
wire [16-1:0] SignExtend; 
wire [16-1:0] ALU_src2;
wire Zero;
wire Overflow;
wire [16-1:0] ALU_result;

//DM
wire [16-1:0] Mem_Readdata;

//branch
wire ZERO;
wire PCSrc;

//ZF
wire [16-1:0] ZeroFilled;

//shifter
wire [16-1:0] Shifter_result;

//PC
wire [16-1:0] SE_shiftleft1;
wire [16-1:0] PC_branch;
wire [14-1:0] Jump_shiftleft1;
wire [16-1:0] PC_jump;

//module
wire Write;

Program_Counter PC(
        .clk_i(clk_i),      
        .rst_n(rst_n),     
        .pc_in_i(PC_in), 
        .PCWrite_i(Write),  
        .pc_out_o(PC_ReadAddress) 
        );
	
Adder Adder1(
        .src1_i(PC_ReadAddress), 
        .src2_i(16'd2), 
        .sum_o(PCadder1_sum)
        );
                
Instr_Memory IM(
        .pc_addr_i(PC_ReadAddress),  
        .instr_o(Instruction)    
        );

wire [15:0] PCadder1_sum_ID;
wire [15:0] Instruction_ID;
wire Flush;
    
Pipe_IFID IFID(
        .clk_i(clk_i), 
        .rst_n(rst_n),
        .Flush_i(Flush),
        .PCadder1_sum_i(PCadder1_sum),
        .Instruction_i(Instruction),
        .IFIDWrite_i(Write), 
        .PCadder1_sum_o(PCadder1_sum_ID), 
        .Instruction_o(Instruction_ID)
        );

wire RegDst_ID;
wire RegWrite_ID;
wire [2-1:0] ALUOp_ID;
wire	 ALUSrc_ID;
wire	 Branch_ID;
wire MemToReg_ID;
wire	 BranchType_ID;
wire	 Jump_ID;
wire	 MemRead_ID;
wire	 MemWrite_ID;
 
Decoder DC(
        .instr_op_i(Instruction_ID[15:13]),
        .RegWrite_o(RegWrite_ID),
        .ALUOp_o(ALUOp_ID),
        .ALUSrc_o(ALUSrc_ID), 
        .RegDst_o(RegDst_ID),
        .Branch_o(Branch_ID), 
        .BranchType_o(BranchType_ID), 
        .MemToReg_o(MemToReg_ID),
        .MemRead_o(MemRead_ID), 
        .MemWrite_o(MemWrite_ID), 
        .Jump_o(Jump_ID) 
        );
       
wire RegWrite_WB;
wire [2:0] RDaddr_WB;
wire [15:0] RSdata_ID;
wire [15:0] RTdata_ID;

Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
        .RSaddr_i(Instruction_ID[12:10]),  
        .RTaddr_i(Instruction_ID[9:7]),  
        .RDaddr_i(RDaddr_WB),
        .RDdata_i(RDdata), 
        .RegWrite_i(RegWrite_WB),
        .RSdata_o(RSdata_ID),  
        .RTdata_o(RTdata_ID)
        );
  
wire [15:0] SignExtend_ID;
      
Sign_Extend SE(
        .data_i(Instruction_ID[6:0]), 
        .data_o(SignExtend_ID)
        );

wire [15:0] ZeroFilled_ID;
        
Zero_Filled ZF( 
        .data_i(Instruction_ID[6:0]), 
        .data_o(ZeroFilled_ID) 
        );

wire [2:0] RSaddr_EX;        
wire RegDst_EX;
wire RegWrite_EX;
wire [2-1:0] ALUOp_EX;
wire	 ALUSrc_EX;
wire	 Branch_EX;
wire MemToReg_EX;
wire	 BranchType_EX;
wire	 Jump_EX;
wire	 MemRead_EX;
wire	 MemWrite_EX;
wire [12:0] Instruction_EX;
wire [15:0] PCadder1_sum_EX;
wire [15:0] RSdata_EX;
wire [15:0] RTdata_EX;
wire [15:0] SignExtend_EX;
wire [15:0] ZeroFilled_EX;
wire [3:0] funct_EX;
wire [2:0] RTaddr_EX;
wire [2:0] RDaddr_EX;
   
Pipe_IDEX IDEX(
            .clk_i(clk_i), 
            .rst_n(rst_n), 
            .Flush_i(Flush),
            .IDEXWrite_i(Write),
            .RSaddr_i(Instruction_ID[12:10]), 
            .RSaddr_o(RSaddr_EX),
            .RegWrite_i(RegWrite_ID), 
            .ALUOp_i(ALUOp_ID), 
            .ALUSrc_i(ALUSrc_ID),
            .RegDst_i(RegDst_ID),
            .Branch_i(Branch_ID),
            .BranchType_i(BranchType_ID), 
            .MemToReg_i(MemToReg_ID), 
            .MemRead_i(MemRead_ID), 
            .MemWrite_i(MemWrite_ID), 
            .Jump_i(Jump_ID),
            .Instr_i(Instruction_ID[12:0]),
            .PCadder1_sum_i(PCadder1_sum_ID),
            .RSdata_i(RSdata_ID), 
            .RTdata_i(RTdata_ID), 
            .SignExtend_i(SignExtend_ID), 
            .ZeroFilled_i(ZeroFilled_ID), 
            .funct_i(Instruction_ID[3:0]), 
            .RTaddr_i(Instruction_ID[9:7]), 
            .RDaddr_i(Instruction_ID[6:4]),
            .RegWrite_o(RegWrite_EX), 
            .ALUOp_o(ALUOp_EX), 
            .ALUSrc_o(ALUSrc_EX), 
            .RegDst_o(RegDst_EX), 
            .Branch_o(Branch_EX), 
            .BranchType_o(BranchType_EX), 
            .MemToReg_o(MemToReg_EX), 
            .MemRead_o(MemRead_EX), 
            .MemWrite_o(MemWrite_EX), 
            .Jump_o(Jump_EX),
            .Instr_o(Instruction_EX),
            .PCadder1_sum_o(PCadder1_sum_EX),
            .RSdata_o(RSdata_EX), 
            .RTdata_o(RTdata_EX), 
            .SignExtend_o(SignExtend_EX), 
            .ZeroFilled_o(ZeroFilled_EX), 
            .funct_o(funct_EX), 
            .RTaddr_o(RTaddr_EX), 
            .RDaddr_o(RDaddr_EX)
            );

assign PC_jump = {PCadder1_sum_EX[15:14], Instruction_EX, 1'b0};

Shifter Shiftleft1( 
        .result(SE_shiftleft1), 
        .leftRight(1'b1),
        .sftSrc(SignExtend_EX)
        );

Adder Adder2(
        .src1_i(PCadder1_sum_EX), 
        .src2_i(SE_shiftleft1),
        .sum_o(PCadder2_sum)
        );
        

wire [15:0] FUResult_MEM; 
wire [15:0] ALU_src1;
wire [1:0] ForwardA;
     
Mux3to1 ForwardAMux(
        .data0_i(RSdata_EX), 
        .data1_i(FUResult_MEM), 
        .data2_i(RDdata), 
        .select_i(ForwardA), 
        .data_o(ALU_src1)
        );

wire [15:0] newRTdata_EX;
wire [1:0] ForwardB;

Mux3to1 ForwardBMux(
        .data0_i(RTdata_EX), 
        .data1_i(FUResult_MEM), 
        .data2_i(RDdata), 
        .select_i(ForwardB), 
        .data_o(newRTdata_EX)
        );
            
Mux2to1 ALUSrcMux(
        .data0_i(newRTdata_EX), 
        .data1_i(SignExtend_EX), 
        .select_i(ALUSrc_EX), 
        .data_o(ALU_src2) 
        );       

ALU ALU(
        .aluSrc1(ALU_src1),
        .aluSrc2(ALU_src2), 
        .ALU_operation_i(ALU_operation), 
        .result(ALU_result), 
        .zero(Zero), 
        .overflow(Overflow)
        );
        
Shifter Shifter(
        .result(Shifter_result), 
        .leftRight(ALU_operation[0]),
        .sftSrc(ALU_src2) 
        );
        
ALU_Ctrl AC(
         .funct_i(funct_EX),
         .ALUOp_i(ALUOp_EX),
         .ALU_operation_o(ALU_operation),
         .FURslt_o(FUResult_Select)
         );
         
Mux3to1 FURsltMux(
        .data0_i(ALU_result), 
        .data1_i(Shifter_result), 
        .data2_i(ZeroFilled_EX), 
        .select_i(FUResult_Select), 
        .data_o(FUResult) 
        );
               
Mux2to1 #(.size(1))BranchTypeMux(
        .data0_i(Zero), 
        .data1_i(~Zero), 
        .select_i(BranchType_EX), 
        .data_o(ZERO) 
        );               

assign PCSrc = Branch_EX & ZERO;

Mux2to1 PCSrcMux(
        .data0_i(PCadder1_sum), 
        .data1_i(PCadder2_sum), 
        .select_i(PCSrc),
        .data_o(PC_branch) 
        );

Mux2to1 JumpMux(
        .data0_i(PC_branch), 
        .data1_i(PC_jump), 
        .select_i(Jump_EX), 
        .data_o(PC_in) 
        );

Mux2to1 #(.size(3))RegDstMux(
        .data0_i(RTaddr_EX), 
        .data1_i(RDaddr_EX), 
        .select_i(RegDst_EX), 
        .data_o(RDaddr) 
        );

wire [2:0] RTaddr_MEM;
wire RegWrite_MEM; 
wire MemToReg_MEM;
wire MemWrite_MEM; 
wire MemRead_MEM; 
wire [15:0] RTdata_MEM;
wire [2:0] RDaddr_MEM;

Pipe_EXMEM EXMEM(
        .clk_i(clk_i), 
        .rst_n(rst_n),
        .RTaddr_i(RTaddr_EX),
        .RTaddr_o(RTaddr_MEM),
        .RegWrite_i(RegWrite_EX),
        .MemToReg_i(MemToReg_EX), 
        .MemWrite_i(MemWrite_EX),
        .MemRead_i(MemRead_EX),
        .FUResult_i(FUResult), 
        .RTdata_i(newRTdata_EX), 
        .RDaddr_i(RDaddr),
        .RegWrite_o(RegWrite_MEM), 
        .MemToReg_o(MemToReg_MEM), 
        .MemWrite_o(MemWrite_MEM), 
        .MemRead_o(MemRead_MEM),
        .FUResult_o(FUResult_MEM), 
        .RTdata_o(RTdata_MEM), 
        .RDaddr_o(RDaddr_MEM)
        );

wire [15:0] newRTdata_MEM;
wire MEM_Forward;

Mux2to1 MEM_ForwardMux(
        .data0_i(RTdata_MEM), 
        .data1_i(RDdata), 
        .select_i(MEM_Forward), 
        .data_o(newRTdata_MEM)
        );

                        
Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(FUResult_MEM),
        .data_i(newRTdata_MEM),
        .MemRead_i(MemRead_MEM),
        .MemWrite_i(MemWrite_MEM),
        .data_o(Mem_Readdata)
        );
 
wire MemToReg_WB;
wire [15:0] Mem_Readdata_WB; 
wire [15:0] FUResult_WB;

Pipe_MEMWB MEMWB(
        .clk_i(clk_i), 
        .rst_n(rst_n),
        .RegWrite_i(RegWrite_MEM), 
        .MemToReg_i(MemToReg_MEM),
        .Mem_Readdata_i(Mem_Readdata), 
        .FUResult_i(FUResult_MEM),
        .RDaddr_i(RDaddr_MEM),
        .RegWrite_o(RegWrite_WB), 
        .MemToReg_o(MemToReg_WB),
        .Mem_Readdata_o(Mem_Readdata_WB), 
        .FUResult_o(FUResult_WB),
        .RDaddr_o(RDaddr_WB)
        );

Mux2to1 MemToRegMux(
        .data0_i(FUResult_WB), 
        .data1_i(Mem_Readdata_WB), 
        .select_i(MemToReg_WB), 
        .data_o(RDdata) 
        );

HazardDetector HD(
        .PCSrc_i(PCSrc), 
        .Jump_i(Jump_EX), 
        .Flush_o(Flush)
        );    
        
Load_Use_HazardDetector LUHD(
        .MemRead_EX_i(MemRead_EX), 
        .MemWrite_ID_i(MemWrite_ID),  
        .RTaddr_EX_i(RTaddr_EX), 
        .RSaddr_ID_i(Instruction_ID[12:10]), 
        .RTaddr_ID_i(Instruction_ID[9:7]), 
        .Write_o(Write)
        );   

EX_ForwardingUnit EXFU(
        .RegWrite_MEM_i(RegWrite_MEM), 
        .RDaddr_MEM_i(RDaddr_MEM), 
        .RSaddr_EX_i(RSaddr_EX), 
        .RTaddr_EX_i(RTaddr_EX), 
        .RegWrite_WB_i(RegWrite_WB), 
        .RDaddr_WB_i(RDaddr_WB),
        .ForwardA_o(ForwardA), 
        .ForwardB_o(ForwardB)
        );
        
MEM_ForwardingUnit MEMFU(
        .MemToReg_WB_i(MemToReg_WB), 
        .MemWrite_MEM_i(MemWrite_MEM), 
        .RTaddr_WB_i(RDaddr_WB), 
        .RTaddr_MEM_i(RTaddr_MEM), 
        .MEM_Forward_o(MEM_Forward)
        );

endmodule

