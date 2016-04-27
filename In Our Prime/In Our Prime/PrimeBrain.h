//
//  PrimeBrain.h
//  In Our Prime
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeBrain : NSObject

- (BOOL)isPrimeNumber:(NSUInteger)primeCandidate;
- (NSArray *)primeFactors:(NSUInteger)theNumber;
- (NSUInteger)largestPrimeInCommon:(NSUInteger)firstNumber secondNumber:(NSUInteger)secondNumber;


@end
