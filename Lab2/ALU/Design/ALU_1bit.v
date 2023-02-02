module ALU_1bit( result, carryOut, a, b, invertA, invertB, aluOp, carryIn, less );
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] aluOp;
  input wire less;
  input wire carryIn;
  
  /*your code here*/
  wire a_comb;
  wire b_comb;
  wire ab_and;
  wire ab_or;
  wire ab_plus;
  
  assign a_comb = invertA ? ~a : a; //using InvertA and 2-to-1 mux to determine signal a should be inverted or not
  assign b_comb = invertB ? ~b : b; //using InvertB and 2-to-1 mux to determine signal b should be inverted or not
  
  assign ab_and = a_comb & b_comb;  //AND gate
  assign ab_or = a_comb | b_comb;   //OR gate
  
  //using prepared module, Full_adder, to do 1-bit addiction
  Full_adder add(.sum(ab_plus), .cout(carryOut), .cin(carryIn), .inp1(a_comb), .inp2(b_comb));
  
  //using 4-to-1 mux and aluOp to determine which signal should be the final result
  assign result = aluOp == 2'b00 ? ab_and : aluOp == 2'b01 ? ab_or : aluOp == 2'b10 ? ab_plus : less;
  
endmodule