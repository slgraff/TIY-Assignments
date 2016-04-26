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

// Declare formValidator
@property (strong, nonatomic) FormValidator * formValidator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.addressTextField.placeholder = @"Address";
    self.nameTextField.placeholder = @"Name";
    
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
        
    } else if ([textfield isEqual:self.addressTextField]) {
        return [textField.text isValidAddress];
    }
    return NO;
}

@end
