//	Author:				Donal Tuohy	
//	Student Number:		14313774
//	Assignment:			Tutorial 1
//	Course:				CS3421 Computer Architecture 2
//	Degree:				Computer Engineering
//	College:			Trinity College Dublin

#include "stdafx.h"         // pre-compiled headers
#include <iostream>         // cout
#include "conio.h"          // _getch
#include "Functions.h"

using namespace std;

int main() {
	int a, b, c, d;

	cout << "Enter three numbers: ";
	cin >> a >> b >> c;
	int mini = min(a, b, c);
	printf("The min of %i, %i and %i is: %i \n", a, b, c, mini);

	cout << "Enter four numbers: ";
	cin >> a >> b >> c >> d;
	int mini2 = p(a, b, c, d);
	printf("The min of %i, %i, %i, %i and 4 is: %i \n", a, b, c, d, mini2);


	cout << "Enter two numbers to calculate the greatest common denominator: ";
	cin >> a >> b;
	int gcdCal = gcd(a, b);
	printf("The gcd of %i and %i is: %i \n", a, b, gcdCal);

	return 0;
}