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

// A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself.

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
        while ((counter * counter) <= primeCandidate) {
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
- (NSMutableArray *)primeFactors:(NSUInteger)theNumber {
    
    // Do I need to initialize thePrimeFactors? Do I do it here inside this method? At the top of this class file?
    // Inside the .h file? I'm confused...
    
    
    NSLog(@"Inside primeFactors");

    
    // Loop through array of numbers. If theNumber % counter = 0 then check to see if prime.
    // If result is YES, add to array primeFactors

    for (int i = 1; i < (theNumber / 2); i += 1) {
        if ((theNumber % i) == 0) {
            if ([self isPrimeNumber:i]) {
                // Add number to array primeFactors
                NSLog(@"isPrimeNumber says %i is prime", i);
                // [self.thePrimeFactors addObject:[NSNumber numberWithInteger:i]]; // convert NSUInteger (type) to NSNumber (object)
                // NSLog(@"thePrimeFactors %@", _thePrimeFactors);
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
