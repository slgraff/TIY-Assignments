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
        
        // Initializing 'stringToEncode' to 'footer', one of the test case words
        NSMutableString *stringToEncode = [NSMutableString stringWithFormat:@"footer"];
        
        // Initialize 'encodedString' to hold our encoded string
        NSMutableString *encodedString = [@"" mutableCopy];
        
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
                    
                    // BUG encodedString is getting appended with an address, not a char
                    [encodedString appendString:[cipherArray objectAtIndex:[azArray indexOfObject:theChar]]];
                } else {
                    [encodedString stringByAppendingString:theChar];
                }
            } else {
                
            }
        }
        
        NSLog(@"Encoded version of %@ is %@", stringToEncode, encodedString);
        
        

        
//        // Initialize string to hold current character
//        NSMutableString *currentChar = [[NSMutableString alloc]init];
//        NSMutableString *newChar = [[NSMutableString alloc]init];
//
//        // Initialize variable theIndex
//        NSInteger theIndex = 0;
//        
//        // Convert helloGreeting to all lower case
//        [helloGreeting setString:[helloGreeting lowercaseString]];
//        
//        
//        for (int charIndex = 0; charIndex < helloGreeting.length; charIndex += 1) {
//            
//            // Get current char in helloGreeting string
//            // NSLog(@"Character at index %d: %C", charIndex, [helloGreeting characterAtIndex:charIndex]);
//            // NSString *theChar = [helloGreeting characterAtIndex:charIndex];
//            
//            // Get the current character from inputString
//            currentChar = [NSMutableString stringWithFormat:@"%C", [helloGreeting characterAtIndex:charIndex]];
//            NSLog(@"Current char: %@", currentChar);
//            
//            // Get the index of currentChar in plainString
//            
//            theIndex = [plainString rangeOfString:currentChar].location;
//            
//            if (theIndex != NSNotFound) {
//                
//                // If found, look up character at same index in cipherString, add it to outputString
//                [atbashGreeting stringByAppendingString:[NSMutableString stringWithFormat:@"%C", [cipherString characterAtIndex:theIndex]]];
//                NSLog(@"%@", atbashGreeting);
//            } else {
//                // If error, keep same character, add to outputString
//                [atbashGreeting stringByAppendingString:currentChar];
//                NSLog(@"%@", atbashGreeting);
//            }

            // theIndex = [plainString rangeOfString:currentChar].location;
            
            // Check to make sure that character is found in plainString
//            if(theIndex != NSNotFound) {
//                // If found, look up character at same index in cipherString, add it to outputString
//                [atbashGreeting stringByAppendingString:[NSMutableString stringWithFormat:@"%C", [cipherString characterAtIndex:theIndex]]];
//                NSLog(@"%@", atbashGreeting);
//
//            } else {
//                // If error, keep same character, add to outputString
//                [atbashGreeting stringByAppendingString:currentChar];
//                NSLog(@"%@", atbashGreeting);
//            }

            // Lookup that index in cipherString
            
            // [cipherString characterAtIndex:theIndex];
//            
//            newChar = [NSMutableString stringWithFormat:@"%C", [cipherString characterAtIndex:theIndex]];
//            
//            NSLog(@"plainString char: %@", newChar);
            
            
            //NSLog(@"Character at index 0 of plainString: %C", [plainString characterAtIndex:0]);
            //NSLog(@"Character at index 0 of cipherString: %C", [cipherString characterAtIndex:0]);

            
            // NSLog (@"%@", [plainString rangeOfString:[helloGreeting characterAtIndex:charIndex]]);
            
            // Lookup character at that index in cipherString
            
            // assign to atbashGreeting
            
            // NSLog(@"%@", [helloGreeting characterAtIndex:charIndex]);
            
            // atbashGreeting = [helloGreeting characterAtIndex:charIndex];
            
//        }
        
        // NSLog(@"%C", [helloGreeting characterAtIndex:0]);
        
        

        
    }
    return 0;
}
