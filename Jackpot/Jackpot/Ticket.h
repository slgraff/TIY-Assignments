//
//  Ticket.h
//  Jackpot
//
//  Created by Steve Graff on 4/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

// Declared BOOL property (value type) for whether or not winner
@property (assign) BOOL winner;

// Property for the payout amount
// nonatomic a keyword added to properties, tells to not worry about multithreading
// We should generally add nonatomic to every property declaration
@property (copy, nonatomic) NSString * payout;

// Create initializer for ticket, instancetype
+(instancetype)ticketUsingQuickPick; // For quick pick ticket
+(instancetype)ticketUsingArray:(NSArray *)picks; // For choosing own numbers


-(void)compareWithTicket:(Ticket*)anotherTicket;

// Declare instance method to display our picks
// Different than NSMutableArray declared in Tickets.m
// To differentiate between instance method and varible, do [self picks]
// returns NSArray
// Referring to just 'picks' is the instance variable
// self.winner would return BOOL property of instance variable
// [self winner]
// [self getWinner] and [self setWinner:Bool] provided for free by ObjC
-(NSArray*) picks;

@end
