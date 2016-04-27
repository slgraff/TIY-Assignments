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


// isPrimeNumber - given an NSUInteger, test to see if it is a prime number
// Return YES if prime, NO if not
// https://en.wikipedia.org/wiki/Primality_test#Pseudocode

- (BOOL)isPrimeNumber:(NSUInteger)primeCandidate {
    // Returns YES if prime

    if (primeCandidate <= 1) {
        return NO;
    } else if ((primeCandidate == 2) || (primeCandidate == 3)) {
        return YES;
    } else if ((primeCandidate % 2 == 0) || (primeCandidate % 3 == 0)) {
        return NO;
    }
    
    int counter = 5;
    while ((counter * counter) < primeCandidate) {
        if (((primeCandidate % counter) == 0) || ((primeCandidate % (primeCandidate + 2)) == 0)) {
            return NO;
        }
        counter += 6;
    }
    return YES;
}


// primeFactors - given an NSUInteger, determine all prime factors for that number
- (NSArray *)primeFactors:(NSUInteger)theNumber {
    return nil;
}




// largestPrimeInCommon - given two NSArrays of numbers, find the largest prime number in both arrays
- (NSUInteger)largestPrimeInCommon:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber {
    return 1;
}



@end
