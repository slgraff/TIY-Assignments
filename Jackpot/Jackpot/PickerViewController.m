//
//  PickerViewController.m
//  Jackpot
//
//  Created by Steve Graff on 4/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "PickerViewController.h"



@interface PickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSArray * _pickerData;
    NSNumber *firstNumber;
    NSNumber *secondNumber;
    NSNumber *thirdNumber;
    NSNumber *fourthNumber;
    NSNumber *fifthNumber;
    NSNumber *sixthNumber;
}

// returns the number of 'columns' to display.


- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED;

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED; // attributed title is favored if both methods are implemented
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED;

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED;

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 6;
}

//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return [self. objectAtIndex:row];
//}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 53;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 40.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            firstNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 1:
            secondNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 2:
            thirdNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 3:
            fourthNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 4:
            fifthNumber = [NSNumber numberWithInteger:row+1];
            break;
        case 5:
            sixthNumber = [NSNumber numberWithInteger:row+1];
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
