module Full_adder(sum,cout,cin,inp1,inp2);

input cin, inp1, inp2;
output sum,cout;
/*your code here*/

//�u�n���䤤��ӼƬO1�A�N�n�i��
assign cout = (inp1 & inp2) | (inp1 & cin) | (inp2 & cin);

//��XOR�ݦ��X��1
assign sum = inp1 ^ inp2 ^ cin;

endmodule