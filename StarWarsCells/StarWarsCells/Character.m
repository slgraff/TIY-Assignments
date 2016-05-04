//
//  Character.m
//  StarWarsCells
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "Character.h"

@implementation Character

+(Character *)characterWithDictionary:(NSDictionary *)charDict {
    
    Character *aCharacter = nil;
    if (charDict) {
        aCharacter = [[Character alloc]init];
        
        // Set characters name
        aCharacter.characterName = [charDict objectForKey:@"characterName"];
        
        // Set characters description
        aCharacter.characterDescription = [charDict objectForKey:@"characterDescription"];
        
        // Set characters image name
        aCharacter.characterImageName = [charDict objectForKey:@"characterImageName"];
    }
    return aCharacter;
    
}

@end
