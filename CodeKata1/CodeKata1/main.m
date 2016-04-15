//
//  main.m
//  CodeKata1
//
//  Created by Steve Graff on 4/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        
        
        /*
        FizzBuzz - Multiples of 3 and 5
        If we list all the natural numbers below 10 that are multiples of 3 or 5 we get 3, 5, 6 and 9.
        The sume of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.
        */
        
        // Initialize the sum variable
        int multiSum = 0;
        
        // Initialize a boolean for whether or not to print each number
        BOOL printNum = NO;
        
        // Loop through numbers from 1 to 1000, exclusive. Determine multiples of 3 or 5, calculate
        // sum of those numbers
        for (int theNum = 1; theNum < 1000; theNum += 1){
            
            // Is number a multiple of 3
            if (theNum % 3 == 0) {
                multiSum += theNum;
                
                if (printNum) {
                    NSLog(@"%d is a multiple of 3", theNum);
                }
            } else if (theNum % 5 == 0) {
                multiSum += theNum;
                
                if(printNum) {
                    NSLog(@"%d is a multiple of 5", theNum);
                }
            }
        }
        // Print the sum of numbers to the log
        NSLog(@"The sum of the numbers is %d", multiSum);
        
        
        
        
    }
    return 0;
}
