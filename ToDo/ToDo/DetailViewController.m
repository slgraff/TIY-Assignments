//
//  DetailViewController.m
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

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
        self.detailTextField.text = [[self.detailItem valueForKey:@"timeStamp"] description]; // set text of detailTextField to our timeStamp
    
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancelButtonTapped:(UIButton*)sender {
    // When cancelling, reload text field from our data model
    self.detailTextField.text = [[self.detailItem valueForKey:@"timeStamp"] description];
}

-(IBAction)saveButtonTapped:(UIButton*)sender {
    // When saving, update our context with edited object
    
    // Convert string in textfield to an NSDate object
    NSString * dateString = self.detailTextField.text;
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    NSDate * newDate = [formatter dateFromString:dateString];
    
    // Store the NSDate
    [self.detailItem setValue:newDate forKey:@"timeStamp"];
    
    self.saveButton.enabled = NO;
    self.cancelButton.enabled = NO;
    
    // Send a message to MasterViewController object that the object has changed
    [self.masterVC detailChangedObject];
}

@end
