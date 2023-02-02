module Program_Counter( clk_i, rst_n, pc_in_i, PCWrite_i, pc_out_o );

//I/O ports
input           clk_i;
input	        rst_n;
input  [16-1:0] pc_in_i;
input PCWrite_i;
output reg [16-1:0] pc_out_o;
 
//Internal Signals
wire [15:0] pc_out_comb;
//Main function
always @(posedge clk_i) begin
    if(~rst_n)
	    pc_out_o <= 0;
	else
	    pc_out_o <= pc_out_comb;
end	  
  
assign pc_out_comb = PCWrite_i == 0 ? pc_out_o : pc_in_i;



endmodule
