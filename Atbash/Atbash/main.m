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
        
        NSMutableString *helloGreeting = [NSMutableString stringWithFormat:@"Hello, Atbash"];
        
        // Declare strings for characters a - z, cipher
        NSString *plainString = @"abcdefghijklmnopqrstuvwxyz";
        NSString *cipherString = @"ZYXWUTSRQPONMLKJIHGFEDCBA";
        
        // Initialize string to hold our encoded string
        NSMutableString *atbashGreeting = [[NSMutableString alloc]init];
        
        // Initialize string to hold current character
        NSMutableString *currentChar = [[NSMutableString alloc]init];
        NSMutableString *newChar = [[NSMutableString alloc]init];

        // Initialize variable theIndex
        NSInteger theIndex = 0;
        
        // Convert helloGreeting to all lower case
        [helloGreeting setString:[helloGreeting lowercaseString]];
        
        
        for (int charIndex = 0; charIndex < helloGreeting.length; charIndex += 1) {
            
            // Get current char in helloGreeting string
            // NSLog(@"Character at index %d: %C", charIndex, [helloGreeting characterAtIndex:charIndex]);
            // NSString *theChar = [helloGreeting characterAtIndex:charIndex];
            
            // Find index of that char in plainString
            currentChar = [NSMutableString stringWithFormat:@"%C", [helloGreeting characterAtIndex:charIndex]];
            NSLog(@"Current char: %@", currentChar);
            
            // Get the index of currentChar in plainString
            // Currently returning a YUGE number. Why? Because "H" is not found in plainString beause it's upper case
            theIndex = [plainString rangeOfString:currentChar].location;

            // Lookup that index in cipherString
            
            // [cipherString characterAtIndex:theIndex];
            
            newChar = [NSMutableString stringWithFormat:@"%C", [cipherString characterAtIndex:theIndex]];
            
            NSLog(@"plainString char: %@", newChar);
            
            
            //NSLog(@"Character at index 0 of plainString: %C", [plainString characterAtIndex:0]);
            //NSLog(@"Character at index 0 of cipherString: %C", [cipherString characterAtIndex:0]);

            
            // NSLog (@"%@", [plainString rangeOfString:[helloGreeting characterAtIndex:charIndex]]);
            
            // Lookup character at that index in cipherString
            
            // assign to atbashGreeting
            
            // NSLog(@"%@", [helloGreeting characterAtIndex:charIndex]);
            
            // atbashGreeting = [helloGreeting characterAtIndex:charIndex];
            
        }
        
        NSLog(@"%C", [helloGreeting characterAtIndex:0]);
        
        

        
    }
    return 0;
}
