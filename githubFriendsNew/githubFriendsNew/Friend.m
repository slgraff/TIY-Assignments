//
//  Friend.m
//  githubFriendsNew
//
//  Created by Steve Graff on 4/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "Friend.h"

@implementation Friend

// Create a class named Friend and add all of the properties that were received from the github user call.
//
// Use the following line to create a URL object for the GitHub API:
// NSString* urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@" , username]
// replace 'username' with the user you want to search for.
// GitHub user request returns a dictionary
// GitHub user repo request returns an array of dictionaries

// 'name' is name of repo in returned array of dictionaries


// Class method Friend
+ (Friend *)friendWithDictionary:(NSDictionary *)friendDict {
    Friend *aFriend = nil;
    if (aFriend) {
        aFriend = [[Friend alloc]init];
        
        // Set the GitHub friend's name
        aFriend.friendLogin = [friendDict objectForKey:@"login"];
        
        // Set the GitHub friend's name
        aFriend.friendName = [friendDict objectForKey:@"name"];

        // Set the GitHub friend's location
        aFriend.friendLocation = [friendDict objectForKey:@"location"];
        
        // Set the GitHub friend's repos URL
        aFriend.friendReposURL = [friendDict objectForKey:@"repos_url"];

        
        // This may need to be handled in DetailViewController.m when
        // performing query to GitHub using repos_url
        // Set the GitHub friend's repositories
        // aFriend.friendRepos = [friendDict objectForKey:@"friendRepos"];
    }
    
    return aFriend;
}


@end



