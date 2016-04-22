//
//  Hero.m
//  HeroTracker
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "Hero.h"

@implementation Hero

+ (Hero *)heroWithDictionary:(NSDictionary *)heroDict {

    Hero *aHero = nil;
    if (heroDict) {
        aHero = [[Hero alloc]init];
        
        // Set hero's name
        aHero.heroName = [heroDict objectForKey:@"heroName"]; // hero's cover name is the name of the dictionary object, i.e. Earthquake, Lionheart, Paladin, etc.
        
        // Set hero's real name
        
        if ([[heroDict objectForKey:@"realFirstName"] isEqualToString:@"Unrevealed"]) {
            // If any is "Unrevealed" set full name to "Unrevealed"
            aHero.heroRealName = @"Unrevealed";
        } else if (!heroDict[@"realFirstName"]) {
            // If realFirstName does not exist, set real name to "Unknown"
            aHero.heroRealName = @"Unknown";
        } else if ([heroDict[@"realMiddleName"]  isEqual: @""]) {
            // If middle name is empty, set full name to just first and last
            aHero.heroRealName = [NSString stringWithFormat:@"%@ %@",
                                  [heroDict objectForKey:@"realFirstName"],
                                  [heroDict objectForKey:@"realLastName"]];
        } else {
            // Set full name to first, middle and last
            aHero.heroRealName = [NSString stringWithFormat:@"%@ %@ %@",
                                  [heroDict objectForKey:@"realFirstName"],
                                  [heroDict objectForKey:@"realMiddleName"],
                                  [heroDict objectForKey:@"realLastName"]];
        }
    
        // Set hero's powers
        aHero.heroPowers = [heroDict objectForKey:@"powers"];
        
    }
    return aHero;
    
}


@end
