//
//  DetailViewController.m
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

// Declaring UITextField delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;

// Declaring UITextView delegates
- (void)textViewDidBeginEditing:(UITextView *)textView;
- (void)textViewDidEndEditing:(UITextView *)textView;

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

// 5/5 created action for 'Do people stuff' button
-(IBAction)ImAPeoplePerson:(id)sender {
    
    // Copied following from MasterViewController
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];  // Pull entity from the data model
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context]; // Create new object to store the entity
    
    // Create a person
    [newManagedObject setValue:@"John" forKey:@"firstName"];
    [newManagedObject setValue:@"Doe" forKey:@"lastName"];
    [newManagedObject setValue:@22 forKey:@"age"];  // @22 makes it an object, not a literal
    
    // Create another person, a spouse
    NSManagedObject *spouseManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context]; // Create new object to store the entity
    
    [spouseManagedObject setValue:@"Jane" forKey:@"firstName"];
    [spouseManagedObject setValue:@"Doe" forKey:@"lastName"];
    [spouseManagedObject setValue:@20 forKey:@"age"];  // @20 makes it an object, not a literal
    
    // Set relationship between objects John (newManagedObject) and Jane (spouseManagedObject)
    [newManagedObject setValue:spouseManagedObject forKey:@"spouse"];
    
    // Save our context
    // 5/5 Copied from MasterViewController.m

    // Context is the memory representation of the objects we've created. This writes it to disk
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    

}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        // Set the text for the title and to do detail
        self.dueDateField.text = [[self.detailItem valueForKey:@"timestamp"]description];
        
        
        // 5/5 Changed below to .title
        self.detailTextField.text = self.detailItem.title;
        // self.detailTextField.text = [self.detailItem valueForKey:@"title"];
        self.todoDetailTextView.text = [self.detailItem valueForKey:@"detail"];
        
        // Grab that state of 'done', set doneSwitch
        [self.doneSwitch setOn:[[self.detailItem valueForKey:@"done"]boolValue] animated:YES];
        
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    // Set delegate for detailTextField
    self.detailTextField.delegate = self;
    
    // Set delegate for todoDetailTextView
    self.todoDetailTextView.delegate = self;
    
    
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
    
    // Save the contents of text field (title) and text view (detail)
    [self.detailItem setValue:self.detailTextField.text forKey:@"title"];
    [self.detailItem setValue:self.todoDetailTextView.text forKey:@"detail"];
    
    NSError *error;
    
    if (![self.detailItem.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    self.saveButton.enabled = NO;
    self.cancelButton.enabled = NO;
    
    // Resign first resonder, aka focus, for text field, text view
    [self.detailTextField resignFirstResponder];
    [self.todoDetailTextView resignFirstResponder];
    
    // Send a message to MasterViewController object that the object has changed
    [self.masterVC detailChangedObject];
}


// Method for handling toggling of the Done switch
-(IBAction)doneSwitchToggled:(UISwitch *)sender {
    
    // Get and store the state of the doneSwitch
    if (self.doneSwitch.isOn) {
        // [self.doneSwitch setOn:NO animated:YES];
        [self.detailItem setValue:@YES forKey:@"done"];

    } else {
        // [self.doneSwitch setOn:YES animated:YES];
        [self.detailItem setValue:@NO forKey:@"done"];
    }
    
    // [self.detailItem setValue:@([self.doneSwitch isOn]) forKey:@"done"];
}


#pragma mark TextField Delegates
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


#pragma mark TextView Delegates

// TextView delegate for when field gains focus
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing");

    // Enable Save and Cancel buttons when user begins editing
    self.saveButton.enabled = YES;
    self.cancelButton.enabled = YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"textViewDidEndEditing");

    // There I go again, implementing a delegate I don't think I'm gonna use
}


//// Only enable Save and Cancel buttons once user has made change to textField
//- (BOOL)textField:(UITextField *)detailTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    text = [detailTextField.text stringByReplacingCharactersInRange:range withString:string];
//    if (detailTextfield == refToTextFieldYouWantToCheck) {
//        if ( ! [textToCheck isEqualToString:text] ) {
//            [theButtonRef setEnabled:YES];
//        }
//    }
//    return YES; //If you don't your textfield won't get any text in it
//}


#pragma mark - Fetched results controller
// 5/5 Copied and pasted this from MasterViewController.m

// fetchedResultsController is our worker for retrieving data
// As a property, has a getter and a setter
- (NSFetchedResultsController *)fetchedResultsController // This is the getter
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;  // If we got one, return it
    }
    
    // Otherwise create a new fetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate. Currently sorting by title
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName"ascending:YES];
    
    // 5/5 Added second sort descriptor, added to our fetch request
    NSSortDescriptor * secondSort = [[NSSortDescriptor alloc]initWithKey:@"firstName" ascending:YES];
    
    // Sorts on sortDescriptor, then secondSort
    [fetchRequest setSortDescriptors:@[sortDescriptor, secondSort]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    // managedObjectContext is where our objects are stored in memory
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil]; // 5/5 Changed cache name to nil
    aFetchedResultsController.delegate = self; // Set our delegate
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    
    
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            NSLog(@"Got an insert here!");
            break;
            
        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            NSLog(@"Got a delete here!");

            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    // UITableView *tableView = self.tableView;
    UITableView *tableView = nil;  // 5/5 changed to nil, disables tableView variable

    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];  // 5/5 commented this out
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // [self.tableView endUpdates];  // 5/5 commented out
}

// Implementation of detailChangedObject
-(void)detailChangedObject {
    // [self.tableView reloadData];
    
    // Copied following from committedEditingStyle
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];  // 'context' is our memory
    
    NSError *error = nil;
    if (![context save:&error]) {  // Save our object to disk
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // [self.tableView reloadData]; // Reload data
    
}




@end
