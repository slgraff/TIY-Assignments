//
//  ViewController.m
//  FormValidator
//
//  Created by Steve Graff on 4/26/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "ViewController.h"
#import "FormValidator.h"



@interface ViewController () <UITextFieldDelegate>

// Declare custom properties
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;



// Declare formValidator
@property (strong, nonatomic) FormValidator * formValidator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nameTextField.placeholder = @"Your Name";
    self.addressTextField.placeholder = @"Address";
    self.cityTextField.placeholder = @"City";
    self.stateTextField.placeholder = @"State";
    self.zipTextField.placeholder = @"Zip";
    self.phoneTextField.placeholder = @"Phone Number";
    
    self.formValidator = [[FormValidator alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// called when 'return' key pressed. Return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.nameTextField]) { // Validate name field
        
        if ([self.formValidator validateName: self.nameTextField.text]) {
            [self.nameTextField resignFirstResponder];
            [self.addressTextField becomeFirstResponder];
            return YES;
        }
        
    } else if ([textField isEqual:self.addressTextField]) { // Validate address field
        if ([self.formValidator validateAddress:self.addressTextField.text]) {
            [self.addressTextField resignFirstResponder];
            [self.cityTextField becomeFirstResponder];
            return YES;
        }
        
    } else if ([textField isEqual:self.cityTextField]) { // Validate city field
        // Call formValidator for city field
        if ([self.formValidator validateAddress:self.cityTextField.text]) {
            [self.cityTextField resignFirstResponder];
            [self.stateTextField becomeFirstResponder];
            return YES;
        }

    } else if ([textField isEqual:self.stateTextField]) { // Validate state field
        // Call formValidator for state field
        if ([self.formValidator validateAddress:self.stateTextField.text]) {
            [self.stateTextField resignFirstResponder];
            [self.zipTextField becomeFirstResponder];
            return YES;
        }
    } else if ([textField isEqual:self.zipTextField]) { // Validate zip field
        // Call formValidator for zip field
        if ([self.formValidator validateAddress:self.zipTextField.text]) {
            [self.cityTextField resignFirstResponder];
            [self.stateTextField becomeFirstResponder];
            return YES;
        }
    } else if ([textField isEqual:self.phoneTextField]) { // Validate phone field
        // Call formValidator for phone field
        // As is last field, do not resign first responder status
        return [self.formValidator validateAddress:self.phoneTextField.text];
        return YES;
        }
    return NO;
}


@end
