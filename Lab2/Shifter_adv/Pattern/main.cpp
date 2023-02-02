#include <iostream>
#include <string>
#include <fstream>
#include <bitset>

using namespace std;

#define PAT_NUM 99

int main()
{
	srand(33);

	ofstream input;
	input.open("Shifter_adv_test2.txt");

	ofstream output;
	output.open("Shifter_adv_ans2.txt");

	for (int patcount = 0; patcount < PAT_NUM; patcount++)
	{
		int leftRight = rand() % 2;

		int shamt_int = rand() % 16;
		bitset<4> shamt(shamt_int);

		bitset<16> sftSrc((rand() << 2) % 65536);

		input << leftRight << shamt << sftSrc << endl;

		bitset<16> goldenAns;

		goldenAns = leftRight ? sftSrc << shamt_int : sftSrc >> shamt_int;

		output << goldenAns << endl;
	}

	return 0;
}