//
//  Ticket.m
//  Jackpot
//
//  Created by Steve Graff on 4/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "Ticket.h"

// Redefine interface by adding opening and closing parens, curly braces
@interface Ticket() {
    
    // Declared method 'picks'
    NSMutableArray * picks;
}
@end

@implementation Ticket

// Create init instance (- sign indicates this) method using template (just type init return)
// Have already alloc'd this
- (instancetype)init  // returns instancetype
{
    self = [super init]; // if super init fails, returns nil
    if (self) {  // checks to make sure that self isn't nil, if is nil won't execute statements
        // Create our properties and instance variables
        picks = [NSMutableArray array];  // array does alloc and init
        self.winner = NO;  // initialize winner with value of NO
        self.payout = @""; // initialize payout with a string
        
    }
    return self;  // returns self, even if nil
}

+(instancetype)ticketUsingQuickPick{  // generates a ticket
    Ticket* aTicket = [[Ticket alloc]init]; // Create and initialize variable aTicket
    
    // To get do while template enter 'dowhile'
    do {
  
        // Call createPick method of the object
        [aTicket createPick];
        
    } while (aTicket.picks.count < 6);
    
    return aTicket;
}

+(instancetype)ticketUsingArray:(NSArray *)picks{  // generates a ticket
    Ticket* ticket = [[Ticket alloc]init];
    
    
    return ticket;
    
}

-(void)storeTheArrayIntoPicks:(NSArray*)array{
    picks = [array mutableCopy];
    
    
    
    
    
}

-(void)createPick{
    
    // int pickInt = rand()  // rand a low level C function, but is deterministic random number
    int pickInt = arc4random() % 54 + 1; // Better random number generator, generates a random Integer. Mod 54 gives us number from 0 to 53, adding 1 gives us 1 to 54 (max pick possible
    NSNumber *pickNumber = [NSNumber numberWithInt:pickInt]; // Put int into an NSNumber container(object). Int is a value type
    
    BOOL dontAdd = NO; // Local variable
    
    // Check to make sure number is unique
    for (NSNumber * numberInArray in picks){
        
        if(numberInArray.intValue == pickInt) {
            // don't add to array
            dontAdd = YES;
        }
    }
    if(!dontAdd) {
        // Store picked number in array
        [picks addObject:pickNumber];
    }
    

}

-(NSArray*)picks {
    return [picks copy]; // Sending a copy of picks that is immutable
}

-(void)compareWithTicket:(Ticket *)anotherTicket{
    // compare our ticket wtih winning ticket
    NSArray* possibleWinningNumbers = anotherTicket.picks;
    int matchCount = 0; // initialize int to count number of matching numbers
    
    // Compare 6 numbers in our ticket to winning numbers, doing 36 comparisons
    for (NSNumber *ourNumber in picks) {
        for (NSNumber *theirNumber in possibleWinningNumbers) {
            if (ourNumber.integerValue == theirNumber.integerValue){
                matchCount += 1;
            }
        }
    }
    
    switch (matchCount) {
        case 1:
            self.winner = YES;
            self.payout = @"1";
            break;
            
        case 2:
            self.winner = YES;
            self.payout = @"1";
            break;
            
        case 3:
            self.winner = YES;
            self.payout = @"5";
            break;
            
        case 4:
            self.winner = YES;
            self.payout = @"10";
            break;
            
        case 5:
            self.winner = YES;
            self.payout = @"100";
            break;
            
        case 6:
            self.winner = YES;
            self.payout = @"1000";
            break;

        default:
            self.payout = @"Sorry, you are not a winner. Please play again.";
            break;
    }
}

-(NSString*)description{
    
    // Overridden NSObject method to perform this specific
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", picks[0], picks[1], picks[2], picks[3], picks[4], picks[5] ];
    
   // return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@", picks[0], picks[1], picks[2], picks[3], picks[4], [picks[5]];
}

@end
