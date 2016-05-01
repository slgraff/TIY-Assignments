//
//  PrimeBrain.h
//  In Our Prime
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeBrain : NSObject

// Declare methods
- (BOOL)isPrimeNumber:(NSUInteger)primeCandidate;
- (NSMutableArray *)primeFactors:(NSUInteger)theNumber;
- (NSUInteger)largestPrimeInCommon:(NSUInteger)firstNumber
                      secondNumber:(NSUInteger)secondNumber;

// Declare properties
@property BOOL isItPrime;
@property (strong, nonatomic) NSMutableArray* thePrimeFactors;
@property NSUInteger largestPrimeFactor;

@end
