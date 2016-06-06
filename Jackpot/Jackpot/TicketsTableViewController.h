//
//  TicketsTableViewController.h
//  Jackpot
//
//  Created by Steve Graff on 4/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@protocol PickerViewControllerDelegate

-(void)winningTicketWasAdded:(Ticket *)ticket;

@end

@interface TicketsTableViewController : UITableViewController <PickerViewControllerDelegate>

@end
