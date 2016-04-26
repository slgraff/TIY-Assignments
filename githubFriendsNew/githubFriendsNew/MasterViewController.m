//
//  MasterViewController.m
//  githubFriends
//
//  Created by Steve Graff on 4/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *friends;

-(IBAction)GoToNewItemViewController:(id)sender;


@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.friends = [[NSMutableArray alloc]init];
    
    // Changed the button to call our method GoToNewItemViewController
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(GoToNewItemViewController:)];
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

// Example of defensive programming
- (void)insertNewObject:(id)sender {
    if (!self.friends) {
        self.friends = [[NSMutableArray alloc] init];
    }
    [self.friends insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.friends[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

// GoToNewItemViewController - Added during lecture
// Also available as a gist here:
// https://gist.github.com/jtligon/a4d01b9e6b406f8f9c50ded5eb13dd13
-(IBAction)GoToNewItemViewController:(id)sender {
    UIAlertController * alertController =
    [UIAlertController alertControllerWithTitle:@"Add a friend"
                                        message:@"Enter a valid github username"
                                 preferredStyle:UIAlertControllerStyleAlert];

    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Username";
    }];
    
    
    // Create object that will 'do the thing' when clicking button
    UIAlertAction * okAlert = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // Grab UITextField so we can reference it later
        // textFields is an NSArray
        UITextField* textField = alertController.textFields.lastObject;
        // or .firstObject or .lastObject, or textFields[0]
        
        NSLog(@"%@", textField.text);
        [_friends addObject:textField.text];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_friends count] -1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }];
    
    // Handle 'Cancel' action
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"User cancelled");
    }];

    
    [self presentViewController:alertController animated:YES completion:nil];
    
    // Alert action to handle errors
    UIAlertAction * errorAlert = [UIAlertAction actionWithTitle:@"Error" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Error!");

    }];
    
    [alertController addAction:okAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:errorAlert];
    
    
    
}
    
#pragma mark - Table View
     
     - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
         return 1;
     }
     
     - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
         return self.friends.count;
     }
     
     - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
         
         NSDate *object = self.friends[indexPath.row];
         cell.textLabel.text = [object description];
         return cell;
     }
     
     - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
         // Return NO if you do not want the specified item to be editable.
         return YES;
     }
     
     - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
         if (editingStyle == UITableViewCellEditingStyleDelete) {
             [self.friends removeObjectAtIndex:indexPath.row];
             [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
         } else if (editingStyle == UITableViewCellEditingStyleInsert) {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
         }
     }
     
@end
