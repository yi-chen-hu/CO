`timescale 1ns / 1ps
`define test_file_Shifter "Shifter_adv_test2.txt"
`define answer_file_Shifter "Shifter_adv_ans2.txt"
`define numOfTest 99


module t_Shifter_Barrel();

	reg clk;
	integer i, score;
		
	reg [35:0] mem_inp_Shifter[0:`numOfTest-1];
	reg [17:0] mem_ans_Shifter[0:`numOfTest-1];
	reg [35:0] inp_Shifter;
	reg [17:0] ans_Shifter;
	
	wire [3:0] shamt;
	wire [15:0] result_Shifter, sftSrc;
 
	Shifter_Barrel shifter( result_Shifter, leftRight, shamt, sftSrc );
	
	assign leftRight = inp_Shifter[20];
	assign shamt = inp_Shifter[19:16];
	assign sftSrc = inp_Shifter[15:0];
  
	initial begin
		clk = 0;
		score = 0;		
	    i = 0;
		
		$readmemb( `test_file_Shifter, mem_inp_Shifter );
		$readmemb( `answer_file_Shifter, mem_ans_Shifter );
		
		#((`numOfTest+1) * 10)
		
	    $display("Correctness = %0d\/%0d \n", score , `numOfTest );	
		$stop;
		
	end
	
	always #5 clk = ~clk;
	
	always@( negedge clk ) begin
	
	  ans_Shifter = mem_ans_Shifter[i];
  	  inp_Shifter = mem_inp_Shifter[i];
	  
	  i = i + 1;
	  	  
	  #1
	  if (i<= `numOfTest)
	  begin
		  if ( ans_Shifter[15:0] == result_Shifter ) begin
		    $display("Shifter_Barrel test data #%0d is correct\n", i );
		    score = score + 1;
		  end
			  
		  else begin
		    $display("Shifter_Barrel test data #%0d is wrong\n", i );	
	        $display("%b\n", ans_Shifter[15:0]);
		  end
	  end
		  	  	  
	end
	

endmodule
