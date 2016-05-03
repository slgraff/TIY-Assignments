//
//  DetailViewController.h
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"


@interface DetailViewController : UIViewController

@property (weak, nonatomic) MasterViewController * masterVC; // Created property to refer to our MasterViewController

@property (strong, nonatomic) NSManagedObject * detailItem; // changed from id to NSManagedObject, allows saving from MasterViewController
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@end

