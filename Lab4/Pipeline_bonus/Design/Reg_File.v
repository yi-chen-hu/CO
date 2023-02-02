module Reg_File( clk_i, rst_n, RSaddr_i, RTaddr_i, RDaddr_i, RDdata_i, RegWrite_i, RSdata_o, RTdata_o );
          
//I/O ports
input           clk_i;
input           rst_n;
input           RegWrite_i;
input  [3-1:0]  RSaddr_i;
input  [3-1:0]  RTaddr_i;
input  [3-1:0]  RDaddr_i;
input  [16-1:0] RDdata_i;

output [16-1:0] RSdata_o;
output [16-1:0] RTdata_o;   

//Internal signals/registers           
reg  signed [16-1:0] Reg_File [0:8-1];     //32 word registers
wire        [16-1:0] RSdata_o;
wire        [16-1:0] RTdata_o;

//Read the data
assign RSdata_o = Reg_File[RSaddr_i] ;
assign RTdata_o = Reg_File[RTaddr_i] ;   

//Writing data when postive edge clk_i and RegWrite_i was set.
always @( negedge rst_n or negedge clk_i  ) begin
    if(rst_n == 0) begin
	    Reg_File[0]  <= 0; Reg_File[1]  <= 0; Reg_File[2]  <= 0; Reg_File[3]  <= 0;
	    Reg_File[4]  <= 0; Reg_File[5]  <= 0; Reg_File[6]  <= 0; Reg_File[7]  <= 0;
	end
    else begin
        if(RegWrite_i) 
            Reg_File[RDaddr_i] <= RDdata_i;	
		else 
		    Reg_File[RDaddr_i] <= Reg_File[RDaddr_i];
	end
end

endmodule     





                    
                    