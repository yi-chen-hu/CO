module ALU( aluSrc1, aluSrc2, ALU_operation_i, result, zero, overflow );

//I/O ports 
input	[15:0]  aluSrc1;
input	[15:0]  aluSrc2;
input	[4-1:0] ALU_operation_i;

output	[15:0]  result;
output		    zero;
output		    overflow;

//Internal Signals
wire		    zero;
wire            overflow;
wire    [16-1:0]result;

//Main function
/*your code here*/
//these signal are carryOut of Full_adder of 16 ALUs repectively 
  wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10,
   cout11, cout12, cout13, cout14, cout15;
  wire set;
  wire invertA, invertB;
  wire [1:0] operation;
  assign invertA = ALU_operation_i[3];
  assign invertB = ALU_operation_i[2];
  assign operation = ALU_operation_i[1:0];
  
  // using prepared module, ALU_1bit,  to implement 16-bit ALU
  //noticed that signal less of ALU_0 should be signal set
  ALU_1bit ALU0(result[0], cout0, aluSrc1[0], aluSrc2[0], invertA, invertB, operation, invertB, set);
  ALU_1bit ALU1(result[1], cout1, aluSrc1[1], aluSrc2[1], invertA, invertB, operation, cout0, 0);
  ALU_1bit ALU2(result[2], cout2, aluSrc1[2], aluSrc2[2], invertA, invertB, operation, cout1, 0);
  ALU_1bit ALU3(result[3], cout3, aluSrc1[3], aluSrc2[3], invertA, invertB, operation, cout2, 0);
  ALU_1bit ALU4(result[4], cout4, aluSrc1[4], aluSrc2[4], invertA, invertB, operation, cout3, 0);
  ALU_1bit ALU5(result[5], cout5, aluSrc1[5], aluSrc2[5], invertA, invertB, operation, cout4, 0);
  ALU_1bit ALU6(result[6], cout6, aluSrc1[6], aluSrc2[6], invertA, invertB, operation, cout5, 0);
  ALU_1bit ALU7(result[7], cout7, aluSrc1[7], aluSrc2[7], invertA, invertB, operation, cout6, 0);
  ALU_1bit ALU8(result[8], cout8, aluSrc1[8], aluSrc2[8], invertA, invertB, operation, cout7, 0);
  ALU_1bit ALU9(result[9], cout9, aluSrc1[9], aluSrc2[9], invertA, invertB, operation, cout8, 0);
  ALU_1bit ALU10(result[10], cout10, aluSrc1[10], aluSrc2[10], invertA, invertB, operation, cout9, 0);
  ALU_1bit ALU11(result[11], cout11, aluSrc1[11], aluSrc2[11], invertA, invertB, operation, cout10, 0);
  ALU_1bit ALU12(result[12], cout12, aluSrc1[12], aluSrc2[12], invertA, invertB, operation, cout11, 0);
  ALU_1bit ALU13(result[13], cout13, aluSrc1[13], aluSrc2[13], invertA, invertB, operation, cout12, 0);
  ALU_1bit ALU14(result[14], cout14, aluSrc1[14], aluSrc2[14], invertA, invertB, operation, cout13, 0);
  ALU_1bit ALU15(result[15], cout15, aluSrc1[15], aluSrc2[15], invertA, invertB, operation, cout14, 0);
  
 //To determine signal set and signal overflow, I use module, ALU_15, which is  designed by myself
  ALU_15 inst(aluSrc1[15], aluSrc2[15], invertA, invertB, cout14, operation, set, overflow);
 
 //NAND gate
  assign zero = ~(result[0] | result[1] | result[2] | result[3] | result[4] | result[5] | result[6] | result[7] | result[8]
   | result[9] | result[10] | result[11] | result[12] | result[13] | result[14] | result[15]);
   
endmodule

module ALU_15(a, b, invertA, invertB, cin, aluOP, set, overflow);

input wire a;
input wire b;
input wire invertA;
input wire invertB;
input wire cin;
input wire[1:0] aluOP;

output wire set;
output wire overflow;

wire a_comb;
wire b_comb;
wire cout;


assign a_comb = invertA ? ~a : a;   //using InvertA and 2-to-1 mux to determine signal a should be inverted or not
assign b_comb = invertB ? ~b : b;   //using InvertB and 2-to-1 mux to determine signal b should be inverted or not

//signal set is signal sum of Full_adder if neglecting overflow
Full_adder add(.sum(set), .cout(cout), .cin(cin), .inp1(a_comb), .inp2(b_comb));

//僅在加減法時考慮，當所做的運算overflow時才為1，其餘狀況皆為0
//當兩個數都是正的，但sum(即set_comb)卻是負的，或是當兩個數都是負的，但sum(即set_comb)卻是正的，這兩種情況都算overflow
//最後將其用boolean expression表示
assign overflow = aluOP == 2'b10 & ((a_comb & b_comb & ~set) | (~a_comb & ~b_comb & set)) ? 1 : 0;

endmodule

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

module Full_adder(sum,cout,cin,inp1,inp2);

input cin, inp1, inp2;
output sum,cout;
/*your code here*/

//只要有其中兩個數是1，就要進位
assign cout = (inp1 & inp2) | (inp1 & cin) | (inp2 & cin);

//用XOR看有幾個1
assign sum = inp1 ^ inp2 ^ cin;

endmodule
