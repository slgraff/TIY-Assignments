//
//  TimeStampTableViewController.m
//  Timer
//
//  Created by Steve Graff on 4/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "TimeStampTableViewController.h"

@interface TimeStampTableViewController ()

// Declared new timeStampArray
@property (strong, nonatomic) NSMutableArray * timeStampArray;

// Declared addTimeStamp method to add time stamp
-(IBAction)addTimeStamp:(id)sender;

@end

@implementation TimeStampTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create new timeStampArray
    self.timeStampArray = [[NSMutableArray alloc]init];
    
    //Alternative ways to do so
//    [NSMutableArray.new]
//    [NSMutableArray array]
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Implemented addTimeStamp method
-(IBAction)addTimeStamp:(id)sender{
    
    // Initialize date with today's date, add to our array
    NSDate *date = [NSDate date];
    [self.timeStampArray addObject: date];
    
    // Create new index path, store our date in the table
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:(self.timeStampArray.count -1) inSection:0];
    
    // @[indexPath] wraps indexPath with an array literal
    // Insert row into table view
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.timeStampArray.count;  // Return count of items in array
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeStampCell" forIndexPath:indexPath];
    
    // Configure the cell...
    // Populate text with index of cell
    // Use the indexPath.row to pull index of cell, resolves issue with all cells using count of items in array
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
