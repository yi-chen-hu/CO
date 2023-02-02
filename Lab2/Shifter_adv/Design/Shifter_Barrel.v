module Shifter_Barrel( result, leftRight, shamt, sftSrc );
    
  output wire[15:0] result;

  input wire leftRight;
  input wire[3:0] shamt;
  input wire[15:0] sftSrc;

  /*your code here*/
wire[4:0] shamt_5bit;
wire[4:0] shamt_5bit_comp;
wire[4:0] shift;
wire out1_1, out1_2, out1_3, out1_4, out1_5, out1_6, out1_7, out1_8,
 out1_9, out1_10, out1_11, out1_12, out1_13, out1_14, out1_15, out1_16,
 out1_17, out1_18, out1_19, out1_20, out1_21, out1_22, out1_23;
wire out2_1, out2_2, out2_3, out2_4, out2_5, out2_6, out2_7, out2_8,
 out2_9, out2_10, out2_11, out2_12, out2_13, out2_14, out2_15, out2_16, out2_17; 

//為了要做32-shamt，也就是shamt的2's complement，所以要先把shamt變成5 bit
assign shamt_5bit = {1'b0, shamt};

//Using the prepared module, Comp_5bit, to get 2's complement of shamt_5bit
Comp_5bit inst(shamt_5bit, shamt_5bit_comp);

//shift is the number of  right rotate
//using 2-to-1 mux and signal leftRight to determine shift is shamt_5bit or shamt_5bit_comp
assign shift = leftRight ? shamt_5bit_comp : shamt_5bit;


//Because there are 17 muxs at middle layer and they can rotate up to 6 bit, there are 17+6 muxs at top layer
//These 23 4-to-1 muxs are controlled by S4S3
Mux4 m1_1(sftSrc[0], sftSrc[8], 0, 0, shift[4:3], out1_1);// m1_1: at top layer and the most right mux
Mux4 m1_2(sftSrc[1], sftSrc[9], 0, 0, shift[4:3], out1_2);// m1_2: at top layer and the second mux from right
Mux4 m1_3(sftSrc[2], sftSrc[10], 0, 0, shift[4:3], out1_3);
Mux4 m1_4(sftSrc[3], sftSrc[11], 0, 0, shift[4:3], out1_4);
Mux4 m1_5(sftSrc[4], sftSrc[12], 0, 0, shift[4:3], out1_5);
Mux4 m1_6(sftSrc[5], sftSrc[13], 0, 0, shift[4:3], out1_6);
Mux4 m1_7(sftSrc[6], sftSrc[14], 0, 0, shift[4:3], out1_7);
Mux4 m1_8(sftSrc[7], sftSrc[15], 0, 0, shift[4:3], out1_8);
Mux4 m1_9(sftSrc[8], 0, 0, sftSrc[0], shift[4:3], out1_9);
Mux4 m1_10(sftSrc[9], 0, 0, sftSrc[1], shift[4:3], out1_10);
Mux4 m1_11(sftSrc[10], 0, 0, sftSrc[2], shift[4:3], out1_11);
Mux4 m1_12(sftSrc[11], 0, 0, sftSrc[3], shift[4:3], out1_12);
Mux4 m1_13(sftSrc[12], 0, 0, sftSrc[4], shift[4:3], out1_13);
Mux4 m1_14(sftSrc[13], 0, 0, sftSrc[5], shift[4:3], out1_14);
Mux4 m1_15(sftSrc[14], 0, 0, sftSrc[6], shift[4:3], out1_15);
Mux4 m1_16(sftSrc[15], 0, 0, sftSrc[7], shift[4:3], out1_16);
Mux4 m1_17(0, 0, sftSrc[0], sftSrc[8], shift[4:3], out1_17);
Mux4 m1_18(0, 0, sftSrc[1], sftSrc[9], shift[4:3], out1_18);
Mux4 m1_19(0, 0, sftSrc[2], sftSrc[10], shift[4:3], out1_19);
Mux4 m1_20(0, 0, sftSrc[3], sftSrc[11], shift[4:3], out1_20);
Mux4 m1_21(0, 0, sftSrc[4], sftSrc[12], shift[4:3], out1_21);
Mux4 m1_22(0, 0, sftSrc[5], sftSrc[13], shift[4:3], out1_22);
Mux4 m1_23(0, 0, sftSrc[6], sftSrc[14], shift[4:3], out1_23);// m1_23 is at top layer and the most left mux


//Because there are 16 muxs at bottom layer and they can rotate up to 1 bit, there are 16+1 muxs at middle layer
//These 17 4-to-1 muxs are controlled by S2S1
Mux4 m2_1(out1_1, out1_3, out1_5, out1_7, shift[2:1], out2_1);// m2_1 is at the middle layer and the most right mux
Mux4 m2_2(out1_2, out1_4, out1_6, out1_8, shift[2:1], out2_2);// m2_2 is at the middle layer and the second mux from right
Mux4 m2_3(out1_3, out1_5, out1_7, out1_9, shift[2:1], out2_3);
Mux4 m2_4(out1_4, out1_6, out1_8, out1_10, shift[2:1], out2_4);
Mux4 m2_5(out1_5, out1_7, out1_9, out1_11, shift[2:1], out2_5);
Mux4 m2_6(out1_6, out1_8, out1_10, out1_12, shift[2:1], out2_6);
Mux4 m2_7(out1_7, out1_9, out1_11, out1_13, shift[2:1], out2_7);
Mux4 m2_8(out1_8, out1_10, out1_12, out1_14, shift[2:1], out2_8);
Mux4 m2_9(out1_9, out1_11, out1_13, out1_15, shift[2:1], out2_9);
Mux4 m2_10(out1_10, out1_12, out1_14, out1_16, shift[2:1], out2_10);
Mux4 m2_11(out1_11, out1_13, out1_15, out1_17, shift[2:1], out2_11);
Mux4 m2_12(out1_12, out1_14, out1_16, out1_18, shift[2:1], out2_12);
Mux4 m2_13(out1_13, out1_15, out1_17, out1_19, shift[2:1], out2_13);
Mux4 m2_14(out1_14, out1_16, out1_18, out1_20, shift[2:1], out2_14);
Mux4 m2_15(out1_15, out1_17, out1_19, out1_21, shift[2:1], out2_15);
Mux4 m2_16(out1_16, out1_18, out1_20, out1_22, shift[2:1], out2_16);
Mux4 m2_17(out1_17, out1_19, out1_21, out1_23, shift[2:1], out2_17);// m2_17 is at the middle layer and the most left mux


//result is 16-bit signal, so there are 16 2-to-1 muxs at the bottom layer
//These 16 2-to-1 muxs are controlled by  S0
Mux2 m3_1(out2_1, out2_2, shift[0], result[0]);// m3_1 is at the bottom layer and the most right mux
Mux2 m3_2(out2_2, out2_3, shift[0], result[1]);// m3_2 is at the bottom layer and the second mux from right
Mux2 m3_3(out2_3, out2_4, shift[0], result[2]);
Mux2 m3_4(out2_4, out2_5, shift[0], result[3]);
Mux2 m3_5(out2_5, out2_6, shift[0], result[4]);
Mux2 m3_6(out2_6, out2_7, shift[0], result[5]);
Mux2 m3_7(out2_7, out2_8, shift[0], result[6]);
Mux2 m3_8(out2_8, out2_9, shift[0], result[7]);
Mux2 m3_9(out2_9, out2_10, shift[0], result[8]);
Mux2 m3_10(out2_10, out2_11, shift[0], result[9]);
Mux2 m3_11(out2_11, out2_12, shift[0], result[10]);
Mux2 m3_12(out2_12, out2_13, shift[0], result[11]);
Mux2 m3_13(out2_13, out2_14, shift[0], result[12]);
Mux2 m3_14(out2_14, out2_15, shift[0], result[13]);
Mux2 m3_15(out2_15, out2_16, shift[0], result[14]);
Mux2 m3_16(out2_16, out2_17, shift[0], result[15]);// m3_16 is at the bottom layer and the most left mux

  endmodule
  
module Comp_5bit(in, out);
//this module implements 2's complement of 5-bit signal

output wire[4:0] out;
input wire [4:0] in;

wire[4:0] in_inv;
wire cout0, cout1, cout2, cout3, cout4;

//first, invert the input signal
assign in_inv = ~in;

//second, add 1 to the inverted signal
Full_adder adder0(out[0], cout0, 0, in_inv[0], 1);
Full_adder adder1(out[1], cout1, cout0, in_inv[1], 0);
Full_adder adder2(out[2], cout2, cout1, in_inv[2], 0);
Full_adder adder3(out[3], cout3, cout2, in_inv[3], 0);
Full_adder adder4(out[4], cout4, cout3, in_inv[4], 0);

endmodule

module Full_adder(sum,cout,cin,inp1,inp2);

input cin, inp1, inp2;
output sum,cout;

//只要有其中兩個數是1，就要進位
assign cout = (inp1 & inp2) | (inp1 & cin) | (inp2 & cin);

//用XOR看有幾個1
assign sum = inp1 ^ inp2 ^ cin;

endmodule

module Mux2(in1, in2, op, out);
// a 2-to-1 mux which is controlled by signal op
output wire out;

// in1 is the right one
// in2 is the left one
input wire in1;
input wire in2;
input wire op;

assign out = op ? in2 : in1;

endmodule

module Mux4(in1, in2, in3, in4, op, out);
// a 4-to-1 mux which is controlled by signal op
output wire out;
// in1 is the most right one, and in4 is the most left one
input wire in1, in2, in3, in4;
input wire[1:0] op;

assign out = op == 2'b00 ? in1 : op == 2'b01 ? in2 : op == 2'b10 ? in3 : in4;

endmodule

