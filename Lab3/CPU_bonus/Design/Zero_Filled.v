module Zero_Filled( data_i, data_o );

//I/O ports
input	[7-1:0] data_i;
output	[16-1:0] data_o;

//Internal Signals
wire	[16-1:0] data_o;

//Main function
/*your code here*/
assign dat_o = {1'b0, data_i, 8'b00000000};

endmodule      
