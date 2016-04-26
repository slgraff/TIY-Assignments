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
- (BOOL) validateName:(NSString *)nameString;
- (BOOL) validateAddress:(NSString *)addressString;
- (BOOL) validateCity:(NSString *)cityString;
- (BOOL) validateState:(NSString *)stateString;
- (BOOL) validateZip:(NSString *)zipString;
- (BOOL) validatePhone:(NSString *)phoneString;


@end
