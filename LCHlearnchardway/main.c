//
//  main.c
//  LCHlearnchardway
//
//  Created by ILYA Toka on 9/14/15.
//  Copyright (c) 2015 ILYA Toka. All rights reserved.
//

#include <stdio.h>

// Macros that prints size of data type
#define LCHSizeofType(type) \
    printf("Size of variable " #type " (type: " #type ") = %lu\n", sizeof(type))

int main(int argc, const char * argv[]) {
    
    // Print data type using macro
    LCHSizeofType(char);
    LCHSizeofType(int);
    LCHSizeofType(float);
    LCHSizeofType(double);
    
    return 0;
}
