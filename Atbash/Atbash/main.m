//
//  main.m
//  Atbash
//
//  Implementation of the Atbash cipher. Encode or decode English words by
//  substituting first letter of alphabet for last, second for second to last, etc.
//
//  Characters that are not a part of the English alphabet (a - z) are left intact.
//
//  Atbash substitution table:
//  Plain: abcdefghijklmnopqrstuvwxyz Cipher: ZYXWVUTSRQPONMLKJIHGFEDCBA
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, Atbash!");
        
        // Initializing 'stringToEncode' to one of the test case words
//        NSMutableString *stringToEncode = [NSMutableString stringWithFormat:@"footer"];
//        NSMutableString *stringToEncode = [NSMutableString stringWithFormat:@"wizard"];
//        NSMutableString *stringToEncode = [NSMutableString stringWithFormat:@"/r/dailyprogrammer"];
        NSMutableString *stringToEncode = [NSMutableString stringWithFormat:@"gsrh rh zm vcznkov lu gsv zgyzhs xrksvi"];
        
        
        // Initialize 'encodedString' to hold our encoded string
        NSMutableString *encodedString = [NSMutableString stringWithCapacity:100];
        
        // Declare arrays for chars a-z, also for ciper chars
        NSArray *azArray = @[@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k",
                             @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v",
                             @"w", @"x", @"y", @"z"];
        
        NSArray *cipherArray = @[@"Z", @"Y", @"X", @"W", @"V", @"U", @"T", @"S", @"R", @"Q",
                                @"P", @"O", @"N", @"M", @"L", @"K", @"J", @"I", @"H", @"G",
                                @"F", @"E", @"D", @"C", @"B", @"A"];
        
        NSLog(@"Beginning encoding. Encoding string '%@'.", stringToEncode);
        NSLog(@"azArray is '%@'", azArray);
        NSLog(@"cipherArray is %@", cipherArray);
        
        
        
        // Loop through each character of stringToEncode
        NSUInteger charIndex;
                                 
        for (charIndex = 0; charIndex < [stringToEncode length]; charIndex += 1) {
            
            // Get character at index charIndex of stringToEncode
            // Check for 'NSNotFound' returned from characterAtIndex, returns unichar
            if ([stringToEncode characterAtIndex:charIndex] != NSNotFound) {
                NSString *theChar = [NSString stringWithFormat:@"%C",[stringToEncode characterAtIndex:charIndex]];
                
                // Get index of theChar in azArray, use that to get char at same index in cipherArray
                // Check for 'NSNotFound' returned from indexOfObject, returns NSUInteger
                if ([azArray indexOfObject:theChar] != NSNotFound) {
                    
                    // Add char from cipherArray to encodedText
                    [encodedString appendString:[NSString stringWithFormat:@"%@",[cipherArray objectAtIndex:[azArray indexOfObject:theChar]]]];
                } else {
                    // If char not found in azArray, append char to encodedString
                    [encodedString stringByAppendingString:theChar];
                }
            } else {
                
            }
        }
        NSLog(@"Encoded version of %@ is %@", stringToEncode, encodedString);
        
    }
    return 0;
}
