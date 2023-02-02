module Shifter( result, leftRight, sftSrc );

//I/O ports 
output	[16-1:0] result;

input			leftRight;
input	[16-1:0] sftSrc ;

//Internal Signals
wire	[16-1:0] result;
  
//Main function
/*your code here*/

assign result = leftRight ? sftSrc << 1 : sftSrc >> 1;

endmodule