//
//  ViewController.h
//  In Our Prime
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *numberField2;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (strong, nonatomic) IBOutlet UIPickerView *methodPicker;

// Declare method to handle button tap
- (IBAction)calculateButtonTapped:(UIButton *)sender;

@end

