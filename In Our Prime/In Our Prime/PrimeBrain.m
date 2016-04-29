//
//  PrimeBrain.m
//  In Our Prime
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "PrimeBrain.h"

@interface PrimeBrain()

@end

@implementation PrimeBrain

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.thePrimeFactors = [[NSMutableArray alloc]init]; // initialize array
    }
    return self;
}


// isPrimeNumber - given an NSUInteger, test to see if it is a prime number
// Return YES if prime, NO if not
// https://en.wikipedia.org/wiki/Primality_test#Pseudocode

- (BOOL)isPrimeNumber:(NSUInteger)primeCandidate {
    // Returns YES if prime
    
    NSLog(@"Inside IsPrimeNumber\nPrime Candidate: %ld", primeCandidate);

    if (primeCandidate <= 1) {
        NSLog(@"%lu is NOT Prime", (unsigned long)primeCandidate);
        return NO;
    } else if ((primeCandidate == 2) || (primeCandidate == 3)) {
        NSLog(@"%lu is Prime", (unsigned long)primeCandidate);
        return YES;
    } else if ((primeCandidate % 2 == 0) || (primeCandidate % 3 == 0)) {
        NSLog(@"%lu is NOT Prime", (unsigned long)primeCandidate);
        return NO;
    } else {
        int counter = 5;
        while ((counter * counter) < primeCandidate) {
            if (((primeCandidate % counter) == 0) || ((primeCandidate % (primeCandidate + 2)) == 0)) {
                NSLog(@"%lu is NOT Prime", (unsigned long)primeCandidate);
                return NO;
            }
            counter += 6;
        }
        NSLog(@"%lu is Prime", (unsigned long)primeCandidate);
        return YES;
    }
}


// primeFactors - given an NSUInteger, determine all prime factors for that number
- (NSArray *)primeFactors:(NSUInteger)theNumber {
    
    NSLog(@"Inside primeFactors");

    
    // Loop through array of numbers. If number mod counter = 0 then check to see if prime.
    // If result is YES, add to array primeFactors

    for (int i = 1; i < (theNumber / 2); i += 1) {
        if ((theNumber % i) == 0) {
            if ([self isPrimeNumber:i]) {
                // Add number to array primeFactors
                [self.thePrimeFactors addObject:[NSNumber numberWithInteger:i]]; // convert NSUInteger (type) to NSNumber (object)
            }
            
        }
    }
    
    NSLog(@"Prime factors of %ld are %@", theNumber, _thePrimeFactors);

    return _thePrimeFactors; // Placeholder, edit when ready to return array of results
}





- (NSUInteger)largestPrimeInCommon:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber {
    
    NSLog(@"Inside largestPrimeInCommon");

    // largestPrimeInCommon - given two numbers, calculate array of prime factors for each number
    // For resulting arrays, calculate the largest prime number found in common to both arrays
    
    // Get prime factors for each number
    // Compare both arrays, put numbers in common to new array
    // Return the largest number in the new array
    
    NSMutableSet *set1 = [NSMutableSet setWithArray:[self primeFactors: firstNumber]];
    NSMutableSet *set2 = [NSMutableSet setWithArray:[self primeFactors: secondNumber]];
    
    // Create an array to hold objects in common to both arrays
    [set1 intersectSet:set2];
    NSArray* commonFactors = [set1 allObjects];

    // Return the largest number in the array
    
    NSLog(@"The largest prime factor of %ld and %ld is %f",firstNumber, secondNumber,  ([[commonFactors valueForKeyPath:@"@max.intValue"]floatValue]));
    
    return [[commonFactors valueForKeyPath:@"@max.intValue"]floatValue];
}



@end
