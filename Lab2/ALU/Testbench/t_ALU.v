`timescale 1ns / 1ps
`define test_file_ALU "ALU_test2.txt"
`define answer_file_ALU "ALU_ans2.txt"
`define numOfTest 99


module t_ALU();

	reg clk;
	integer i, score;
		
	reg [35:0] mem_inp_ALU[0:`numOfTest-1];
	reg [17:0] mem_ans_ALU[0:`numOfTest-1];
	reg [35:0] inp_ALU;
	reg [17:0] ans_ALU;
	
	wire zero, overflow, invertA, invertB;
	wire [1:0] operation;
	wire [15:0] result_ALU, aluSrc1, aluSrc2;
 
	ALU alu( result_ALU, zero, overflow,aluSrc1, aluSrc2, invertA, invertB, operation );
	
	assign aluSrc1 = inp_ALU[31:16];
	assign aluSrc2 = inp_ALU[15:0];
	assign invertA = inp_ALU[35];
	assign invertB = inp_ALU[34];
	assign operation = inp_ALU[33:32];
  
	initial begin
		clk = 0;
		score = 0;		
	    i = 0;
	  
		$readmemb( `test_file_ALU, mem_inp_ALU );
		$readmemb( `answer_file_ALU, mem_ans_ALU );
		
		#((`numOfTest+1) * 10)
		
	    $display("Correctness = %0d\/%0d \n", score , `numOfTest );	
		$stop;
		
	end
	
	always #5 clk = ~clk;
	
	always@( negedge clk ) begin
					  	  
	  ans_ALU = mem_ans_ALU[i];
  	  inp_ALU = mem_inp_ALU[i];
	  
	  i = i + 1;
	  #1
	  if (i<= `numOfTest)
	  begin
          if ( ans_ALU[17] == overflow && ans_ALU[16] == zero && ans_ALU[15:0] == result_ALU ) 
          begin
            $display("ALU test data #%0d is correct\n", i );
            score = score + 1;
          end  
          else 
          begin
            $display("ALU test data #%0d is wrong\n", i );	
            $display("Your ans is: %18b\n", {overflow, zero, result_ALU});
            $display("Ans is: %18b\n", ans_ALU);
          end
	  end
		  	  	  
	end
	

endmodule
