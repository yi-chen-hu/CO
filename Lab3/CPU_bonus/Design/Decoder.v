module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Branch_o, BranchType_o, MemToReg_o, MemRead_o, MemWrite_o, Jump_o );
     
//I/O ports
input	[3-1:0] instr_op_i;

output			RegWrite_o;
output	[2-1:0] ALUOp_o;
output			ALUSrc_o;
output	        RegDst_o;
output			Branch_o;
output			BranchType_o;
output			MemToReg_o;
output			MemRead_o;
output			MemWrite_o; 
output			Jump_o;

//Internal Signals
wire			RegWrite_o;
wire	[2-1:0] ALUOp_o;
wire			ALUSrc_o;
wire	        RegDst_o;
wire			Branch_o;
wire			BranchType_o;
wire			MemToReg_o;
wire			MemRead_o;
wire			MemWrite_o; 
wire			Jump_o;

//Main function
/*your code here*/
reg			RegWrite_reg;
reg	[2-1:0] ALUOp_reg;
reg			ALUSrc_reg;
reg	        RegDst_reg;
reg			Branch_reg;
reg			BranchType_reg;
reg			MemToReg_reg;
reg			MemRead_reg;
reg			MemWrite_reg; 
reg			Jump_reg;

always@(*)
    case(instr_op_i)
        3'b000: RegWrite_reg = 1;
        3'b001: RegWrite_reg = 1;
        3'b010: RegWrite_reg = 1;
        3'b011: RegWrite_reg = 1;
        3'b100: RegWrite_reg = 0;
        3'b101: RegWrite_reg = 0;
        3'b110: RegWrite_reg = 0;
        3'b111: RegWrite_reg = 0;
     endcase
   
assign RegWrite_o = RegWrite_reg;  
     
always@(*)
    case(instr_op_i)
        3'b000: ALUOp_reg = 2'b10; 
        3'b001: ALUOp_reg = 2'b00;  
        3'b010: ALUOp_reg = 2'b11;
        3'b011: ALUOp_reg = 2'b00;
        3'b100: ALUOp_reg = 2'b00;
        3'b101: ALUOp_reg = 2'b01;
        3'b110: ALUOp_reg = 2'b01;
        3'b111: ALUOp_reg = 2'b00;
    endcase
    
assign ALUOp_o = ALUOp_reg;

always@(*)
    case(instr_op_i)
        3'b000: ALUSrc_reg = 0;
        3'b001: ALUSrc_reg = 1;
        3'b010: ALUSrc_reg = 0;
        3'b011: ALUSrc_reg = 1;
        3'b100: ALUSrc_reg = 1;
        3'b101: ALUSrc_reg = 0;
        3'b110: ALUSrc_reg = 0;
        3'b111: ALUSrc_reg = 0;
     endcase
     
assign ALUSrc_o = ALUSrc_reg;

always@(*)
    case(instr_op_i)
        3'b000: RegDst_reg = 1;
        3'b001: RegDst_reg = 0;
        3'b010: RegDst_reg = 0;
        3'b011: RegDst_reg = 0;
        default:RegDst_reg = 0;
     endcase
     
assign RegDst_o = RegDst_reg;

always@(*)
    case(instr_op_i)
        3'b101: Branch_reg = 1;
        3'b110: Branch_reg = 1;
        default:Branch_reg = 0;
    endcase
    
assign Branch_o = Branch_reg;

always@(*)
    case(instr_op_i)
        3'b101: BranchType_reg = 0;
        3'b110: BranchType_reg = 1;
        default:BranchType_reg = 0;
    endcase
    
assign BranchType_o = BranchType_reg;

always@(*)
    case(instr_op_i)
        3'b111: Jump_reg = 1;
        default:Jump_reg = 0;
    endcase
    
assign Jump_o = Jump_reg;

always@(*)
    case(instr_op_i)
        3'b011: MemRead_reg = 1;
        default:MemRead_reg = 0;
    endcase
    
assign MemRead_o = MemRead_reg;

always@(*)
    case(instr_op_i)
        3'b100: MemWrite_reg = 1;
        default:MemWrite_reg = 0;
    endcase
    
assign MemWrite_o = MemWrite_reg;

always@(*)
    case(instr_op_i)
        3'b011: MemToReg_reg = 1;
        default:MemToReg_reg = 0;
    endcase
    
assign MemToReg_o = MemToReg_reg;

endmodule
