//
//  PickerViewController.h
//  Jackpot
//
//  Created by Steve Graff on 4/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketsTableViewController.h"

@interface PickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

// @property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
// @property (strong, nonatomic) IBOutlet UIPickerView *numberPicker;

@property (weak, nonatomic) IBOutlet Ticket *pickerView;

@property (strong, nonatomic) id<UIPickerViewDelegate> delegate;




@end

