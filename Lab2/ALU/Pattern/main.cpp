#include <iostream>
#include <fstream>
#include <bitset>
#include <string>

#define PAT_NUM 99

using namespace std;

bitset<16> toBitSet(int n);

int main()
{
	srand(67);

	ofstream input;
	input.open("ALU_test2.txt");
	
	ofstream output;
	output.open("ALU_ans2.txt");

	for (int patcount = 0; patcount < PAT_NUM; patcount++)
	{
		int invertA;
		int invertB;
		int aluOP;
		string aluOP_str;

		switch (rand() % 6)
		{
		case 0:	
			invertA = 0;
			invertB = 0;
			aluOP = 2;
			aluOP_str = "10";
			break;
		case 1:	
			invertA = 0;
			invertB = 1;
			aluOP = 2;
			aluOP_str = "10";
			break;
		case 2:
			invertA = 0;
			invertB = 0;
			aluOP = 0;
			aluOP_str = "00";
			break;
		case 3:
			invertA = 0;
			invertB = 0;
			aluOP = 1;
			aluOP_str = "01";
			break;
		case 4:
			invertA = 1;
			invertB = 1;
			aluOP = 0;
			aluOP_str = "00";
			break;
		case 5:
			invertA = 0;
			invertB = 1;
			aluOP = 3;
			aluOP_str = "11";
			break;
		}
		//rand()只能產生0 ~ 32767(即15bit)，即使去改RAND_MAX也沒用，所以用移位的讓其變更多bit
		int num1 = (rand() << 2) % 65536 - 32768;
		int num2 = (rand() << 2) % 65536 - 32768;

		bitset<16>aluSrc1;
		bitset<16>aluSrc2;

		aluSrc1 = toBitSet(num1);
		aluSrc2 = toBitSet(num2);

		input << invertA << invertB << aluOP_str << aluSrc1 << aluSrc2 << endl;

		bitset<16> goldenAns;
		string overflow_str = "0";
		string zero_str;
		int sum;

		if (!invertA && !invertB)
			sum = num1 + num2;
		else
			sum = num1 - num2;


		if (aluOP_str == "10")
		{
			if (sum > 32767)
			{
				overflow_str = "1";
				goldenAns = toBitSet(sum - 65536);
			}
			else if (sum < -32768)
			{
				overflow_str = "1";
				goldenAns = toBitSet(sum + 65536);
			}
			else
			{
				overflow_str = "0";
				goldenAns = toBitSet(sum);
			}
		}
		else if (!invertA && !invertB && aluOP_str == "00")
		{
			goldenAns = aluSrc1 & aluSrc2;
		}
		else if (aluOP_str == "01")
		{
			goldenAns = aluSrc1 | aluSrc2;
		}
		else if (invertA && invertB && aluOP_str == "00")
		{
			goldenAns = (aluSrc1 | aluSrc2).flip();
		}
		else if (aluOP_str == "11")
		{
			goldenAns = num1 < num2 ? bitset<16>("1") : bitset<16>("0");
		}

		zero_str = goldenAns == 0 ? "1" : "0";

		output << overflow_str << zero_str << goldenAns << endl;
	}

	return 0;
}


bitset<16> toBitSet(int n)
{
	bitset<16> value;

	if (n >= 0)
	{
		value = bitset<16>(n);
	}
	else
	{
		value = bitset<16>(-1 * (n + 1)).flip();
	}

	return value;
}
