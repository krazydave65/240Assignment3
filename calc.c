//========1=========2=========3=========4=========5=========6=========7=========8
//Author information
//  Author name: David Pedroza
//  Author email: krazydave65@fullerton.edu
//Course information
//  Course number: CPSC240
//  Assignment number: 3
//  Due date: 2014-Sep-29
//Project information
//  Project title: Condensed Amortization Schedule
//  Purpose: Find the total Current and Total Power by adding and diving ymm Registers
//  Status: No known errors
//  Gnu compiler: gcc -c -m64 -Wall -std=c99 -l calc.lis -o calc.o calc.c
#include <math.h>

//Amortization Calculation
//parameters: apr, principle, term
double calc(double i,double p,long n){

  double mp;
  i = i/12;
  mp = p * ( i + ( i / ( pow(1+i, n) - 1 ) ) ) ;

  return mp;
}
