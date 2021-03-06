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

@property (strong, atomic) NSArray * pickerData;
@property (strong, nonatomic) NSString * pickerSelection;
@property (strong, nonatomic) PrimeBrain * brain;

@property NSUInteger *primeCandidate;
@property (strong, nonatomic) NSMutableString * primeFactorsString;
@property (strong, nonatomic) NSMutableString * largestPrimeFactor;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialize picker
    self.pickerData = @[@"Prime number", @"Prime factors", @"Largest Prime Factor"];
    [_methodPicker selectRow:0 inComponent:0 animated:YES];
    
    // Initialize value of pickerSelection to 'Prime number'
    _pickerSelection = @"Prime number";

    
    // Connect data
    self.methodPicker.dataSource = self;
    self.methodPicker.delegate = self;
    
    // Initialize second text field state
    _numberField2.enabled = NO;
    _numberField2.placeholder = @"";
    
    // Initialize the primeCandidate
    _primeCandidate = 0;
    
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
// NOTE: ONLY called when value of picker when picker changes from initial value
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Selected value: %@", [_pickerData objectAtIndex:row]);
    
    // Store current value of picker row
    self.pickerSelection = [_pickerData objectAtIndex:row];

    // Check selected row in picker, set numberField placeholder
    if ([self.pickerSelection isEqualToString: @"Largest Prime Factor"]) {
            [_numberField2 setEnabled: YES];
            _numberField2.placeholder = @"Enter a second number";

            NSLog(@"Setting numberField2 to ENABLED");
    } else {
        [_numberField2 setEnabled: NO];
        _numberField2.placeholder = @"";
        _numberField2.text = @"";


        NSLog(@"Setting numberField2 to DISABLED");

    }
}

- (IBAction)calculateButtonTapped:(UIButton *)sender {
    NSLog(@"Calculate button was tapped");
    
    NSLog(@"Picker selection: %@", _pickerSelection);
    
    // Grab values for number fields
    NSUInteger enteredNumber = [_numberField.text integerValue];
    NSUInteger enteredNumber2 = [_numberField2.text integerValue];
    
    // Execute appropriate primality method based on value of picker
    
    // ** isPrimeNumber **
    if ([_pickerSelection  isEqual: @"Prime number"]) {
        
        if ([self.brain isPrimeNumber:enteredNumber]) {
            [self.resultsLabel setText:@"The number is prime!"];
        } else {
            [self.resultsLabel setText:@"The number is NOT prime!"];
        }
        
        
    // ** primeFactors **
    } else if ([_pickerSelection  isEqual: @"Prime factors"]) {
        
        // Pass entered number to primeFactors method
        NSArray *primeFactors = [self.brain primeFactors:enteredNumber];
        
        // Initialize primeFactorsString
        self.primeFactorsString = @"The prime factors are ";

        // Loop through primeFactors, build string of prime factors
        for (int i = 0; i < primeFactors.count; i += 1) {
            NSMutableString *numString = [primeFactors[i] stringValue];
            self.primeFactorsString = [self.primeFactorsString stringByAppendingString:numString];
            if (i < primeFactors.count - 1) {
                self.primeFactorsString = [self.primeFactorsString stringByAppendingString:@", "];
            }
        }
        
        
        NSLog(@"primeFactorsString: %@", self.primeFactorsString);
        [self.resultsLabel setText:self.primeFactorsString];
        
        
    // ** largestPrimeInCommon **
    } else if ([_pickerSelection  isEqual: @"Largest Prime Factor"]) {
        // Initilize largestPrimeFactor string
        
        // Getting crash when running largestPrimeInCommon:
        //  'Attempt to mutate immutable object with appendString:'
        // This line was converting NSMutableString to NSString:
        // self.largestPrimeFactor = @"Largest prime factor is ";
        
        NSUInteger lrgFctr = [self.brain largestPrimeInCommon:enteredNumber secondNumber:enteredNumber2];
        
//        NSLog(@"lrgFctr: %lu", (unsigned long)lrgFctr);
//        
//        // Append largest prime factor in common to end of string
//        
//        NSMutableString *largestPrimeFactor= [[NSMutableString alloc]init];
//        [largestPrimeFactor stringByAppendingString:@"Largest prime factor is "];
//
//        NSLog(@"largestPrimeFactor %@", largestPrimeFactor);
//
//        // NSMutableString *lrgFctrStr = [NSMutableString stringWithFormat:@"%ld", lrgFctr];
//        [self.largestPrimeFactor stringByAppendingString:[NSMutableString stringWithFormat:@"%ld", lrgFctr]];
//        
//        NSLog(@"largestPrimeFactor %@", largestPrimeFactor);
        
        // set resultsLabel to largest common prime factor
        [self.resultsLabel setText: [NSString stringWithFormat:@"Largest prime factor is %lu", (unsigned long)lrgFctr]];

        
    } else {
        NSLog(@"Error! No primality method called!");
    }
}


@end
