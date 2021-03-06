//
//  DetailViewController.h
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "ToDo.h"


@interface DetailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, NSFetchedResultsControllerDelegate>

// 5/5 add delegate of NSFetchedResultsControllerDelegate above, added two below properties (fetchedResultsController, managedObjectContext)

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) MasterViewController * masterVC; // Created property to refer to our MasterViewController

// 5/5 changed this to a ToDo object
@property (strong, nonatomic) ToDo * detailItem; // changed from id to NSManagedObject, allows saving from MasterViewController

@property (weak, nonatomic) IBOutlet UITextField *dueDateField;
@property (weak, nonatomic) IBOutlet UISwitch *doneSwitch;
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;
@property (weak, nonatomic) IBOutlet UITextView *todoDetailTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@end

