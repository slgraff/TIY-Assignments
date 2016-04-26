//
//  FormValidator.h
//  FormValidator
//
//  Created by Steve Graff on 4/26/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FormValidator : NSObject

// Declaring method
- (BOOL) isValidName:(NSString *)nameString;
- (BOOL) isValidAddress:(NSString *)addressString;
- (BOOL) isValidCity:(NSString *)cityString;
- (BOOL) isValidState:(NSString *)stateString;
- (BOOL) isValidZip:(NSString *)zipString;
- (BOOL) isValidPhone:(NSString *)phoneString;


@end
