module Shifter_bonus( result, op, sftSrc, shamt );

//I/O ports 
output	[16-1:0] result;

input	[1:0] op;
input	[16-1:0] sftSrc ;
input   [15:0] shamt;

reg [15:0] result_reg;


always@(*)
    case(op)
        2'b00:  result_reg = sftSrc >> 1;
        2'b01:  result_reg = sftSrc << 1;
        2'b10:  result_reg = sftSrc >> shamt;
        2'b11:  result_reg = sftSrc << shamt;
    endcase
    
assign result = result_reg;

endmodule