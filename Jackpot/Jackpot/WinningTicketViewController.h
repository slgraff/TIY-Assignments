//
//  WinningTicketViewController.h
//  Jackpot
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WinningTicketViewControllerDelegate <NSObject>
@required

// Declaration for returning the picked numbers
-(void)returnThePickedNumbers;

@optional
-(void)sayThanksForTheNumbers;

@end

@interface WinningTicketViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView * pickerView;

@property (weak, nonatomic) IBOutlet id <WinningTicketViewControllerDelegate> delegate; // id is a pointer to an object (id includes the asterick). Need to tell the delegate which contract it is fulfilling, i.e. WinningTicketViewControllerDelegate


-(IBAction)checkTicket:(UIButton*)sender;


@end
