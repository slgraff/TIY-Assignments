//
//  main.m
//  CodeKata1
//
//  Created by Steve Graff on 4/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

// Declaration of function FizzBuzz
void FizzBuzz(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        FizzBuzz();
        
    }
    return 0;
}


/*
 FizzBuzz
 Multiples of 3 and 5
 If we list all the natural numbers below 10 that are multiples of 3 or 5 we get 3, 5, 6 and 9.
 The sume of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.
*/
void FizzBuzz(){

    
    // Initialize the sum variable
    int multiSum = 0;
    
    // Set the maximum number
    int maxNum = 1000;
    
    // Set the desired multiples
    int fizz = 3;
    int buzz = 5;
    
    // Initialize boolean for whether or print, FIZZBUZZ
    BOOL printNum = NO;
    BOOL fizzBuzz = YES;
    
    // Loop through numbers, find multiples of 3 or 5, calculate sum
    for (int theNum = 1; theNum < maxNum; theNum += 1){
        
        // Is number a multiple of 3
        if (theNum % fizz == 0 && theNum % buzz == 0) {
            multiSum += theNum;
            
            if (printNum) {
                NSLog(@"%d is a multiple of %d", theNum, fizz);
            }
            
            if (fizzBuzz) {
                NSLog(@"FIZZBUZZ");
            }
            
        } else if (theNum % fizz == 0) {
                multiSum += theNum;
                
                if(printNum) {
                    NSLog(@"%d is a multiple of %d", theNum, buzz);
                }
                
                if (fizzBuzz) {
                    NSLog(@"FIZZ");
                }
        } else if (theNum % buzz == 0) {
            multiSum += theNum;
            
            if(printNum) {
                NSLog(@"%d is a multiple of %d", theNum, buzz);
            }
            
            if (fizzBuzz) {
                NSLog(@"BUZZ");
            }
        }
    }
    // Print the sum of numbers to the log
    NSLog(@"The sum of the numbers is %d", multiSum);
}
