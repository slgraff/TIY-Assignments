//
//  DetailViewController.m
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailTextField.text = [self.detailItem valueForKey:@"title"]; // set text of detailTextField to our timestamp
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    // Set delegate for detailTextField
    self.detailTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelButtonTapped:(UIButton*)sender {
    // When cancelling, reload text field from our data model
    self.detailTextField.text = [self.detailItem valueForKey:@"title"];
}

-(IBAction)saveButtonTapped:(UIButton*)sender {
    // When saving, update our context with edited object
    
//    // Convert string in textfield to an NSDate object
//    NSString * dateString = self.detailTextField.text;
//    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0000"]; // Set formatter string format (NSDate was returning nil)
//    NSDate * newDate = [formatter dateFromString:dateString];
    
    // Store the NSDate
    [self.detailItem setValue:self.detailTextField.text forKey:@"title"];
    NSError *error;
    
    if (![self.detailItem.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    self.saveButton.enabled = NO;
    self.cancelButton.enabled = NO;
    
    // Resign first resonder, aka focus, for text field
    [self.detailTextField resignFirstResponder];
    
    // Send a message to MasterViewController object that the object has changed
    [self.masterVC detailChangedObject];
}

// TextField delegate - captures when textfield gains focus, i.e. user begins editing
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"textFieldDidBeginEditing");

    // Enable Save and Cancel buttons when user begins editing
    self.saveButton.enabled = YES;
    self.cancelButton.enabled = YES;
}

// TextField delegate - captures when field loses focus, i.e. user done editing
- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textFieldDidEndEditing");
    
    // Is this useful to me in this program? I dunno...
    
}

@end
