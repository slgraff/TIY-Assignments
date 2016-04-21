//
//  WinningTicketViewController.m
//  Jackpot
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "WinningTicketViewController.h"

@interface WinningTicketViewController () <UIPickerViewDelegate, UIPickerViewDataSource> { // delegate does stuff, data source describes the data
    NSMutableArray * pickedNumbers; // To hold picked numbers
    BOOL hasPickedAllNumbers;
}


@end

@implementation WinningTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pickedNumbers = [ @[ [NSNumber numberWithInt:0],
                       [NSNumber numberWithInt:0],
                       [NSNumber numberWithInt:0],
                       [NSNumber numberWithInt:0],
                       [NSNumber numberWithInt:0],
                       [NSNumber numberWithInt:0]] mutableCopy];
    
    hasPickedAllNumbers = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkTicket:(UIButton*)sender{
    [self.delegate returnThePickedNumbers]; // what are the numbers to be returned?
    
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    // Are picking a total of 6 numbers
    return 6;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    // Each row can hold numbers from 1 to 53
    return 53;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
        // NSInteger passed in is row number
        return [NSString stringWithFormat:@"%ld", (long)row + 1];
    }

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    pickedNumbers[component] = [NSNumber numberWithLong:row+1];
    
    // Check to make sure we've picked all numbers (i.e. none are 0)
    pickedNumbers
    
    
    NSLog(@"%ld was chosen in component %ld", row + 1, component);
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
