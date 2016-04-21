//
//  TicketsTableViewController.m
//  Jackpot
//
//  Created by Steve Graff on 4/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "Ticket.h"
#import "WinningTicketViewController.h"

@interface TicketsTableViewController () <WinningTicketViewControllerDelegate> {

    // Need to declare instance variable, need to wrap in curly braces
    // pointer to NSMutableArray
    NSMutableArray *tickets;
    
    // Delcare counters for tracking money spent and won
    int moneySpent;
    int moneyWon;
}

-(IBAction)createTicket:(id)sender;

@end

@implementation TicketsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize tickets array
    tickets = [[NSMutableArray alloc]init];
    
    // Initialize title for TableView
    self.title = @"Won: $0  Spent: $0";
    
    // Intialize variables for tracking money spent and won
    moneySpent = 0;
    moneyWon = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // return count of number of elements in tickets array
    return tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lottoTicket" forIndexPath:indexPath];
    
    // Configure the cell...
    Ticket * aTicket = tickets[indexPath.row];
    cell.textLabel.text = [aTicket description]; // NSObject provides description attribute, we override in Ticket.m
    cell.detailTextLabel.text = aTicket.payout; // Set payout for ticket
    
    if (aTicket.winner == YES) {
        // Set the color to red if winner
        cell.detailTextLabel.textColor = [UIColor greenColor];
    } else if (aTicket.winner == NO) {
        // Set color to red if loser
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
        
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

// Setting delegate for the winning ticket view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"GIVE ME SOMETHING TO LOOK FOR"]) {
        WinningTicketViewController * wtvc = (WinningTicketViewController *) segue.destinationViewController;
        wtvc.delegate = self;
    }
}

 
-(IBAction)createTicket:(id)sender{
    Ticket * aTicket = [Ticket ticketUsingQuickPick];
    [tickets addObject:aTicket];
    
    moneySpent += aTicket.ticketPrice;
    
    // Update the title
    self.title = [NSString stringWithFormat:@"Won: $%d  Spent: $%d", moneyWon, moneySpent];
    
    // Tell table view to reload table data
    [self.tableView reloadData];
}

-(IBAction)checkForWinningTickets:(id)sender{
    // Method to check if any tickets in table match a winning ticket
    
    // Reset to moneyWon to 0
    moneyWon = 0;
    
    // Create a winning ticket
    Ticket * winningTicket = [Ticket ticketUsingQuickPick];
    
    
    for (Ticket* theLottoTicket in tickets) {
        // call compareWithTicket for every ticket in picks theLottoTicket
        [theLottoTicket compareWithTicket:winningTicket];

        if (theLottoTicket.winner == YES) {
            moneyWon += [theLottoTicket.payout intValue];
            
            // Update the title
            self.title = [NSString stringWithFormat:@"Won: $%d  Spent: $%d", moneyWon, moneySpent];
        }
    }
    [self.tableView reloadData];

}



@end
