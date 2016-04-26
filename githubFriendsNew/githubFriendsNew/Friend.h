//
//  Friend.h
//  githubFriendsNew
//
//  Created by Steve Graff on 4/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

// Declare properties
@property (nonatomic) NSString *urlString;
@property (nonatomic) NSMutableData *receivedData;
@property (nonatomic) NSDictionary *jsonResponse;

@property (nonatomic) NSString *friendLogin;
@property (nonatomic) NSString *friendName;
@property (nonatomic) NSString *friendLocation;
@property (nonatomic) NSString *friendAvatar;

@property (nonatomic) NSString *friendReposURL;

@property (nonatomic) NSDictionary *friendRepos;

// repos_url
//

// Declare class method 'Friend'
+ (Friend *)friendWithDictionary:(NSDictionary *)friendDict;


@end
