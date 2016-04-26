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

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.nameTextField]) {
        // Check number of words in text field
        
        if ([self.formValidator validateName: self.nameTextField.text]) {
            [self.nameTextField resignFirstResponder];
            [self.addressTextField becomeFirstResponder];
            return YES;
        }
        
    } else if ([textField isEqual:self.addressTextField]) {
        return [self.formValidator validateAddress:self.addressTextField.text];
    } else if ([textField isEqual:self.addressTextField]) {
        // Call formValidator for city field
    } else if () {
        // Call formValidator for state field
    } else if () {
        // Call formValidator for zip field
    } else if () {
        // Call formValidator for phone field
    }
        
    return NO;
}




@end
