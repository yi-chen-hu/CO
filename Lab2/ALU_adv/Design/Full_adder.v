module Full_adder(sum,cout,cin,inp1,inp2);

input cin, inp1, inp2;
output sum,cout;
/*your code here*/

//只要有其中兩個數是1，就要進位
assign cout = (inp1 & inp2) | (inp1 & cin) | (inp2 & cin);

//用XOR看有幾個1
assign sum = inp1 ^ inp2 ^ cin;

endmodule