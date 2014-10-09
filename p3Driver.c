//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
//Author information
//  Author name: David Pedroza
//  Author email: Krazydave65@csu.fullerton.edu
//  Author location: Fullerton, Calif.
//Course information
//  Course number: CPSC240
//  Assignment number: 3
//  Due date: 2014-Sep-29
//Project information
//  Project title: Current Curcuits
//  Purpose: The purpose of this programming assignment is to calculate the
//           condensed amortization schedule for 4 loans. In this program I
//           use function calls to a C file, loops and iterations. This
//           program outputs the total interest a customer will pay after
//           a giving loan.
//                  
//  Status: Executed as expected
//  Project files: p3Driver.c, p3Main.asm, calc.c
//Module information
//  File name: p3Driver.c
//  This module's call name: p3.out  This module is invoked by the user.
//  Language: C
//  Date last modified: 2014-Sept-29
//  Purpose: This module is the top level driver: it will call p3Main
//  File name: p3Driver.c
//  Status: In production.  No known errors.
//  Future enhancements: None planned
//Translator information (Tested in Linux shell)
//  Gnu compiler: gcc -c -m64 -Wall -std=c99 -l p3Driver.lis -o p3Driver.o
//         p3Driver.c
//  Gnu linker:   gcc -m64 -o p3.out p3Driver.o p3Main.o debug.o calc.o
//  Execute:      ./p3.out
//  Page width: 172 columns
//  Begin comments: 36
//  Optimal print specification: Landscape, 7 points or smaller, monospace,
//     8½x11 paper

#include <stdio.h>
#include <stdint.h>

extern double p3();
extern double calc(double,double,long);

int main()
{double return_code = -99.9;
 printf("%s","\n\nThis program is brought to you by David Pedroza.\n\n");
 printf("%s","This is Assignment 3\n");
 return_code = p3();

 printf("%s %1.12lf\n","The value returned to the driver is ", return_code);

 printf("%s","The driver program will next send a zero to the operating system.  Enjoy your day.\n");

 return 0;
}//End of main
