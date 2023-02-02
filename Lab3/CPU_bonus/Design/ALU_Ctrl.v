module ALU_Ctrl( funct_i, ALUOp_i, ALU_operation_o, FURslt_o);

//I/O ports 
input      [4-1:0] funct_i;
input      [2-1:0] ALUOp_i;

output     [4-1:0] ALU_operation_o;  
output     [2-1:0] FURslt_o;

//Internal Signals
wire		[4-1:0] ALU_operation_o;
wire		[2-1:0] FURslt_o;

//Main function
/*your code here*/
reg [3:0] ALU_operation_reg;
reg [1:0] FURslt_reg;

always@(*)
    case(ALUOp_i)
        2'b10:begin
            case(funct_i)
                4'b0000:begin
                    ALU_operation_reg = 4'b0010;
                    FURslt_reg = 0;
                end
                4'b0001:begin
                    ALU_operation_reg = 4'b0110;
                    FURslt_reg = 0;
                end
                4'b0010:begin
                    ALU_operation_reg = 4'b0000;
                    FURslt_reg = 0;
                end
                4'b0011:begin
                    ALU_operation_reg = 4'b0001;
                    FURslt_reg = 0;
                end
                4'b0100:begin
                    ALU_operation_reg = 4'b1100;
                    FURslt_reg = 0;
                end
                4'b0101:begin
                    ALU_operation_reg = 4'b0111;
                    FURslt_reg = 0;
                end
                4'b0110:begin
                    ALU_operation_reg = 4'b0001;
                    FURslt_reg = 1;
                end
                4'b0111:begin
                    ALU_operation_reg = 4'b0000;
                    FURslt_reg = 1;
                end
                4'b1000:begin
                    ALU_operation_reg = 4'b0011;
                    FURslt_reg = 1;
                end
                4'b1001:begin
                    ALU_operation_reg = 4'b0010;
                    FURslt_reg = 1;
                end
                default:begin
                    ALU_operation_reg = 4'b0010;
                    FURslt_reg = 0;
                end
            endcase
        end
        2'b00:begin
            ALU_operation_reg = 4'b0010;
            FURslt_reg = 0;
        end
        2'b11:begin
            ALU_operation_reg = 4'b0000;
            FURslt_reg = 2'b10;
        end
        2'b01:begin
            ALU_operation_reg = 4'b0110;
            FURslt_reg = 0;
        end
        default:begin
            ALU_operation_reg = 4'b0000;
            FURslt_reg = 0;
        end
    endcase

assign ALU_operation_o = ALU_operation_reg;  
assign FURslt_o = FURslt_reg;           
               
endmodule
