//
//  ViewController.m
//  In Our Prime
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "ViewController.h"
#import "PrimeBrain.h"

@interface ViewController () {
    NSArray * _pickerData;
}

@property (strong, nonatomic) PrimeBrain * brain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize picker data
    _pickerData = @[@"Prime number", @"Prime factors", @"Largest Prime Factor"];
    
    // Connect data
    self.methodPicker.dataSource = self;
    self.methodPicker.delegate = self;
    
    // Initialize second text field state
    _numberField2.enabled = NO;
    
    // Initialize the PrimeBrain object
    _brain = [[PrimeBrain alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)numberField2{
    return NO;
}


#pragma mark Picker View Delegate Methods

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

// Capture the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Selected value: %@", [_pickerData objectAtIndex:row]);
    // Check selected row in picker, set numberField placeholder
    if ([[_pickerData objectAtIndex:row] isEqualToString: @"Largest Prime Factor"]) {
            [_numberField2 setEnabled: YES];
            NSLog(@"Setting numberField2 to ENABLED");
    } else {
        [_numberField2 setEnabled: NO];
        NSLog(@"Setting numberField2 to DISABLED");

    }
    
    // NSInteger indexSelected = [pickerView selectedRowInComponent:0];
    
//    // Check selected row in picker, set numberField placeholder
//    if ([[_pickerData objectAtIndex:row]  isEqual: @"Prime number"]) {
//        self.numberField.placeholder = @"Enter a number";
//    } else if ([[_pickerData objectAtIndex:row]  isEqual: @"Prime factors"]) {
//        self.numberField.placeholder = @"Enter a number";
//    } else if ([[_pickerData objectAtIndex:row]  isEqual: @"Largest Prime factor"]) {
//        self.numberField.placeholder = @"Enter two numbers";
//    }
    
    
}

- (IBAction)calculateButtonTapped:(UIButton *)sender {
    NSLog(@"Calculate button tapped");
    
    // Call isPrimeNumber when tapped
    NSString *enteredNumber = [_numberField text];
    
    
    // [brain isPrimeNumber enteredNumber]  // how can I call isPrimeNumber function in PrimeBrain and pass in number entered in interface???
    
    // Will need to check for selection in picker, call appropriate method
}


@end
