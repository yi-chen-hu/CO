module Adder( src1_i, src2_i, sum_o);

//I/O ports
input	[15:0] src1_i;
input	[15:0] src2_i;
output	[15:0] sum_o;

//Internal Signals
wire	[15:0] sum_o;
    
//Main function
/*your code here*/
assign sum_o = src1_i + src2_i;

endmodule
