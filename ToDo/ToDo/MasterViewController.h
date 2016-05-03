//
//  MasterViewController.h
//  ToDo
//
//  Created by Steve Graff on 5/3/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

// Creating instance method for MasterViewController to get notified when context of an object has changed in the DetailViewController
-(void)detailChangedObject;

@end

