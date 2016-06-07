//
//  HighVoltageTableViewController.h
//  HighVoltage
//
//  Created by Steve Graff on 6/6/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HighVoltageTableViewController.h"
#import "CalcViewController.h"

#import "ElectricCalc.h"

@protocol HighVoltageTableViewControllerDelegate

-(void)energyFormWasSelected:(NSMutableArray *)energyFormString;

@end

@interface HighVoltageTableViewController : UITableViewController <HighVoltageTableViewControllerDelegate>

@end
