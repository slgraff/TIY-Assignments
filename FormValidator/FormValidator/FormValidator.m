//
//  FormValidator.m
//  FormValidator
//
//  Created by Steve Graff on 4/26/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "FormValidator.h"

@implementation FormValidator

// Worker class to validate entered name
- (BOOL) validateName:(NSString *)nameString {
    
    return [[nameString componentsSeparatedByString:@" "]count] > 1;
}


// Worker class to validate entered address
- (BOOL) validateAddress:(NSString*)addressString{
    NSTextCheckingType detectorType = NSTextCheckingTypeAddress;
    
    NSError * error;
    
    NSDataDetector * dataDetector = [NSDataDetector dataDetectorWithTypes:detectorType error:&error];  //&error dereferences the error
    
    __block BOOL rc = NO;  // Is a special BOOL used inside a block, release when block is released
    
    [dataDetector enumerateMatchesInString:addressString options:kNilOptions range:
     NSMakeRange(0, [addressString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
         // For specified range, if address found in string, run block of code
         rc = YES;
     }];
    return rc;  // If YES we found address, if NO we did not
}

-(BOOL) validateZip:(NSString *)zipString{
    BOOL rc = NO;
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Location of characters in this string are all found
    rc = ([zipString length] == 5) && ([zipString rangeOfCharacterFromSet:set].location != NSNotFound);
    
    return rc;
}


@end
