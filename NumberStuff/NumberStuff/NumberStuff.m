//
//  NumberStuff.m
//  NumberStuff
//
//  Created by Steve Graff on 5/11/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "NumberStuff.h"

@implementation NumberStuff

#pragma mark - Thousand Ints
+(NSArray*)thousandInts {

    // Implement the array
    NSMutableArray *numberArray = [[NSMutableArray alloc]init];
    
    for(int i = 1; i <=1000; i += 1) {
        [numberArray addObject:[NSNumber numberWithInt:i]];
        NSLog(@"%d", i);
    }

    NSLog(@"Count of numbers in array: %lu", (unsigned long)[numberArray count]);
    
    return numberArray;
}



#pragma mark Random Ints
+(NSArray*)randomInts {
    
    NSMutableArray *secondArray = [NSMutableArray array];
    while (secondArray.count < 1000) {
        secondArray[secondArray.count] = [NSNumber numberWithUnsignedInteger:arc4random_uniform(100)];
    }

    return secondArray;
}




#pragma mark - Random Characters
+(NSArray*)randomStrings {
    
    int theCount = 1;
    // Repeat 1000 times
    
    // Iinitialize NSString containg lower and uppoer case letters
    NSString *letterString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQURTUVWXYZ";
    
    // Initialize array of strings to hold our generated strings
    NSMutableArray *randomWords = [[NSMutableArray alloc]init];
    
    
    while (theCount <= 1000) {
        
        // Initialize a mutable string to hold our created six char string
        NSMutableString *randomString = [NSMutableString stringWithCapacity:6];
        
        // Create a random string containing six characters, store in array
        for (int numChars = 1; numChars <= 6; numChars += 1) {
            
            [randomString appendFormat: @"%C", [letterString characterAtIndex:arc4random_uniform([letterString length])]];
        }
        
        [randomWords addObject:randomString];
        
        
        theCount += 1;
    }
    NSLog(@"Created array containing %lu six character strings.", (unsigned long)[randomWords count]);
    
    return randomWords;
}


@end