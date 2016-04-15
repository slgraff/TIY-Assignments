//
//  main.m
//  CodeKata1
//
//  Created by Steve Graff on 4/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

// Declaration of functions FizzBuzz and Palindrome
void FizzBuzz(void);
void Palindrome(void);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        FizzBuzz();
        Palindrome();
        
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
    int ceilingNum = 1000;
    
    // Set the desired multiples
    int fizz = 3;
    int buzz = 5;
    
    // Initialize boolean for whether or print, FIZZBUZZ
    BOOL printNum = NO;
    BOOL fizzBuzz = YES;
    
    // Loop through numbers, find multiples of 3 or 5, calculate sum
    for (int theNum = 1; theNum < ceilingNum; theNum += 1){
        
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




/*
 Palmindrome
 A palindromic number reads the same both ways. The largest palindrome made from the
 product of two 2-digit numbers is 9009 = 91 x 99. Find the largest palmindrome made from
 the product of two 3-digit numbers.
 
 String palindrome test cases:
 mom
 dad
 amanaplanacanalpanama
 
 Possible algorithms:
 1. Convert number to string, step thorugh chars in reverse order and store in new string. Compare both strings.
 2. In case of palindrome only need to compare half of string. Compare first and last, compare second and second from last, until
 you reach the middle (length/2)
 3. Divide number by 10 to get the last digit, set to new number, multiply that by 10. Repeat until through all digits
*/
void Palindrome(){
    
    // Initialize constants
    // const int minNum = 100;
    // const int maxNum = 999;
    
    // Declare variables
    int theProduct;
    NSMutableString * theProductString = [[NSMutableString alloc]init];
    NSMutableString * theReverseProductString = [[NSMutableString alloc]init];
    NSMutableString * palindrome = [[NSMutableString alloc]init];
    
    // Calculate product of two 3-digit numbers, assuming that they can be same number
    // Convert product int to string, read each character from string starting at end, put in new variable
    // Compare the original string with the reversed version, if same then is palindrome
    
    for (int firstFactor = 100; firstFactor < 1000; firstFactor += 1){
        for (int secondFactor = 100; secondFactor < 1000; secondFactor += 1){
            [theReverseProductString setString:@""];
            
            
            // Calculate product of two numbers, convert to string
            theProduct = firstFactor * secondFactor;
            theProductString = [NSMutableString stringWithFormat:@"%d", theProduct];
            // NSLog(@"%@", theProductString);
            
            // Loop through each char of string in reverse, copy to another string
            for(NSInteger count = ([theProductString length] -1); count >= 0; count--){
                [theReverseProductString appendFormat:[NSString stringWithFormat:@"%c", [theProductString characterAtIndex:count]]];
                
//                NSLog(@"Character at index %d of string %@", count, theProductString);
//                NSLog(@"Character: %c", [theProductString characterAtIndex:count]);
            }
            
            // Compare two strings, if equal then we have a palindrome
            if ([theProductString isEqualToString:theReverseProductString]){
                [palindrome setString: theProductString];
            }
        }
    }
    NSLog(@"The largest palindrome is %@", palindrome);
    
}
