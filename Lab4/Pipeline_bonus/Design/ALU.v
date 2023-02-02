module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input signed [15:0] aluSrc1;
input signed [15:0] aluSrc2;
input [4-1:0] ALU_operation_i;

output reg [15:0] result;
output zero;
output overflow;



always@(*)
    case(ALU_operation_i)
        4'b0010: result = aluSrc1 + aluSrc2;
        4'b0110: result = aluSrc1 - aluSrc2;
        4'b0000: result = aluSrc1 & aluSrc2;
        4'b0001: result = aluSrc1 | aluSrc2;
        4'b1100: result = ~(aluSrc1 | aluSrc2);
        4'b0111: result = (aluSrc1 < aluSrc2) ? 16'd1 : 16'b0;
    endcase
    
assign zero = result == 16'b0 ? 1 : 0;

endmodule
