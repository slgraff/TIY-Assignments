//
//  MasterViewController.m
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDo.h"

@interface MasterViewController () {
    
    NSDateFormatter * dateFormatter;

}

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Inserts a new object into the data model
// This is the 'C' in CRUD

// There are different patterns for the life cycle of objects. Can choose to create the object, or user can cancel and we discard it.

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];  // Pull entity from the data model
    
    // Create new ToDo
    ToDo *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // 5/5 above line replaces below commented out line
    // NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context]; // Create new object to store the entity
        
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    [newManagedObject setValue:@"To Do Title" forKey:@"title"]; // Using key-value pairs to manage attributes
    [newManagedObject setValue:@"To Do Detail" forKey:@"detail"];
    
    // Create a new date, format it
    dateFormatter = [[NSDateFormatter alloc]init];
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MM-dd-yyyy"
                                                             options:0
                                                              locale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:formatString];
    NSDate *todaysDate = [NSDate date];
    
    NSString *todaysDateString = [dateFormatter stringFromDate:todaysDate];
    
    // Set value of 'timestamp' to todayDateString
    [newManagedObject setValue:[dateFormatter dateFromString:todaysDateString]forKey:@"timestamp"];
    
    
    // Set default value for 'done'
    [newManagedObject setValue:@NO forKey:@"done"]; // @NO wraps 'NO' into an object, allows us to pass it as argument
    
    
    // Save the context.
    // Context is the memory representation of the objects we've created. This writes it to disk
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        
        controller.masterVC = self; // Added this
        
        [controller setDetailItem:object];  // This is the object that is passed to detailViewController and displayed there
        
        controller.managedObjectContext = self.managedObjectContext; // 5/5 added this line, points to already existing managed object context
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [self configureCell:cell withObject:object];  // Configure cell with object that we created
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// In a table view this is what gets fired when we hit delete button
// There are other editing styles that you can use to rearrange items in table (this method does not do that)
// This is one thing that does the 'R' (Restore) in CRUD
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) { // This is of style delete
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];  // 'context' is our memory
        // Context is a container, has objects inside of it
        // Context is somewhat like an array
        
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            
        NSError *error = nil;
        if (![context save:&error]) {  // Save our object to disk
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)configureCell:(UITableViewCell *)cell withObject:(NSManagedObject *)object {
    
    // configure our cell label and detail label
    cell.textLabel.text = [object valueForKey:@"title"];
    cell.detailTextLabel.text = [[object valueForKey:@"timestamp"]description];
    
    
}

#pragma mark - Fetched results controller


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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ToDo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // 5/5 adding NSPredicate
    // Way to search, returns BOOL if found
    NSPredicate *fetchPredicate = [NSPredicate predicateWithFormat:@"%K CONTAINS%@", @"title", @"To Do"]; // Searches for 'Temporary' contained in 'title' field
    
    // Can also use CONTAINS LIKE MATCHES BEGINSWITH ENDSWITH AND OR NOT
    // OR is an 'inclusive' OR, one or both can be true
    
    // Does Core Data does NOT support 'exlusive' OR (XOR), but there are
    // ways to do it
    
    // Set our fetch predicate
    [fetchRequest setPredicate:fetchPredicate];
    
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate. Currently sorting by title
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
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
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withObject:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
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
    
    [self.tableView reloadData]; // Reload data

}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

@end
