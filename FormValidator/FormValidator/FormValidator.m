//
//  FormValidator.m
//  FormValidator
//
//  Created by Steve Graff on 4/26/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "FormValidator.h"

@implementation FormValidator


#pragma mark - Validator Methods

// Worker class to validate entered name
- (BOOL) isValidName:(NSString *)nameString {
    
    return [[nameString componentsSeparatedByString:@" "]count] > 1;
}


// Worker class to validate entered address
- (BOOL) isValidAddress:(NSString*)addressString{
    NSTextCheckingType detectorType = NSTextCheckingTypeAddress;
    
    NSError * error;
    
    NSDataDetector * dataDetector = [NSDataDetector dataDetectorWithTypes:detectorType error:&error];  //&error dereferences the error
    
    __block BOOL rc = NO;  // Is a special BOOL used inside a block, release when block is released
    
    [dataDetector enumerateMatchesInString:addressString options:kNilOptions range:
     NSMakeRange(0, [addressString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
         
         NSLog(@"%@", [result description]);
         
         // For specified range, if address found in string, run block of code
         rc = YES;
     }];
    return rc;  // If YES we found address, if NO we did not
}

// Worker class to validate entered city
- (BOOL) isValidCity:(NSString *)cityString {
    
    // For checking city just make sure it's at least two characters
    
//    NSTextCheckingType detectorType = NSTextCheckingCityKey; // NSTextCheckingCityKey is a type for addresses component
//    
//    NSError * error;
//    
//    NSDataDetector * dataDetector = [NSDataDetector dataDetectorWithTypes:detectorType error:&error];
    
    __block BOOL rc = NO;
    
    if ([cityString length] >=2 ) {
        rc = YES;
    }
    
//    [dataDetector enumerateMatchesInString:cityString options:kNilOptions range:NSMakeRange(0, [cityString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        // For specified range, if city found in string run block of code
//        rc = YES;
//    }];

    return rc; // If YES we found city, if NO we did not
}

// Worker class to validate entered state
- (BOOL) isValidState:(NSString *)stateString {
    
    // For checking state just make sure it's at least two characters

    
//    NSTextCheckingType detectorType = NSTextCheckingStateKey;
//    
//    NSError * error;
//    
//    NSDataDetector * dataDetector = [NSDataDetector dataDetectorWithTypes:detectorType error:&error];
    
    __block BOOL rc = NO;
    
//    [dataDetector enumerateMatchesInString:stateString options:kNilOptions range:NSMakeRange(0, [stateString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//        // For specified range, if state found in string run block of code
//        rc = YES;
//    }];
    
    if ([stateString length] >=2 ) {
        rc = YES;
    }
    
    return rc; // If YES we found city, if NO we did not
}


// Worker class to validate entered zip code
// New solution provided by Jeff
-(BOOL) isValidZip:(NSString *)zipString{
    BOOL rc = NO;
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    // Inverted set, i.e. is every character EXCEPT for those in set
    set = [set invertedSet];
    
    NSRange myRange =[zipString rangeOfCharacterFromSet:set];
    
    rc = (myRange.location == NSNotFound);
    
    rc = ([zipString length] ==5) && rc;
    
    return rc;
}

// Worker class to validate entered phone number
- (BOOL) isValidPhone:(NSString *)phoneString {
    
    NSTextCheckingType detectorType = NSTextCheckingTypePhoneNumber;
    
    NSError * error;
    
    NSDataDetector * dataDetector = [NSDataDetector dataDetectorWithTypes:detectorType error:&error];
    
    __block BOOL rc = NO;
    
    [dataDetector enumerateMatchesInString:phoneString options:kNilOptions range:NSMakeRange(0, [phoneString length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        // For specified range, if phone found in string run block of code
        rc = YES;
    }];
    return rc;  // If YES we found phone number, if NO we did not
}


@end
