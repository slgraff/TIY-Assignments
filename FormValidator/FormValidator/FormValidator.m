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

@end
