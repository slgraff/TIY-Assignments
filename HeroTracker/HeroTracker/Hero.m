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
        // If any is 'Unrevealed' set full name to 'Unrevealed'
        // Otherwise, assemble by joining realFirstName, realMiddleName, realLastName
        if ([[heroDict objectForKey:@"realFirstName"] isEqualToString:@"Unrevealed"]) {
            aHero.heroRealName = @"Unrevealed";
        } else {
            
            // Need to handle empty strings for any name value
            // If all three are empty, set to 'Unrevealed' or just ""?
            
            aHero.heroRealName = [NSString stringWithFormat:@"%@ %@ %@", [heroDict objectForKey:@"realFirstName"], [heroDict objectForKey:@"realMiddleName"], [heroDict objectForKey:@"realLastName"]];
        }
        
        // Set hero's powers
        aHero.heroPowers = [heroDict objectForKey:@"powers"];
        
    }
    return aHero;
    
}


@end
