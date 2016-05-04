//
//  Character.h
//  StarWarsCells
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property (nonatomic) NSString *characterName;
@property (nonatomic) NSString *characterDescription;

+(Character *)characterWithDictionary:(NSDictionary *)charDict;


@end
