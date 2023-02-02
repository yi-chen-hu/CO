module Sign_Extend( data_i, data_o );

//I/O ports
input	[7-1:0]     data_i;
output	[16-1:0]    data_o;

//Internal Signals
wire	[16-1:0]    data_o;

//Main function
/*your code here*/
reg[16-1:0] out;

always @(*)
    if(data_i[6])
        out = {9'b111111111, data_i};
    else
        out = {9'b000000000, data_i};
        
assign data_o = out;

endmodule      
