//
//  main.c
//  LCHlearnchardway
//
//  Created by ILYA Toka on 9/14/15.
//  Copyright (c) 2015 ILYA Toka. All rights reserved.
//

#include <stdio.h>

// Macros that prints size of variable
// TODO: define macro here

int main(int argc, const char * argv[]) {
    
    // Define variables with specific types
    char a;
    int b;
    float c;
    double d;
    
    // TODO: Replace this with macro
    printf("Size of variable a (type: char) = %lu\n", sizeof(a));
    printf("Size of variable b (type: int) = %lu\n", sizeof(b));
    printf("Size of variable c (type: float) = %lu\n", sizeof(c));
    printf("Size of variable d (type: double) = %lu\n", sizeof(d));
    
    return 0;
}
