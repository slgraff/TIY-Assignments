//
//  Hero.h
//  HeroTracker
//
//  Created by Steve Graff on 4/21/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hero : NSObject

@property (nonatomic) NSString *heroName;
@property (nonatomic) NSString *heroRealName;
@property (nonatomic) NSString *heroPowers;



+ (Hero *)heroWithDictionary:(NSDictionary *)heroDict;


@end
