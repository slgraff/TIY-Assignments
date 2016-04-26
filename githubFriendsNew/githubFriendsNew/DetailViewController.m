//
//  DetailViewController.m
//  githubFriendsNew
//
//  Created by Steve Graff on 4/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "DetailViewController.h"
#import "Friend.h"

// Set to be a delegate for NSURLSession, UITableViewDelegate, UITableViewDataSource
// sessionDidCompleteWithError
@interface DetailViewController () <NSURLSessionDelegate, UITableViewDelegate, UITableViewDataSource>

// Property for JSON data received from GitHub site
@property NSMutableData *receivedData;

// friends is a mutable array of dictionaries
@property NSMutableArray *friends;


@property (weak, nonatomic) IBOutlet UITableView *FriendDetailTableView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
        
        // Define a user name
        NSString * userName = [self.detailItem description];
        
        // Create URL to GitHub with username
        NSString * urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@", userName];
        
        // Create the NSURL string using the URL string from above
        NSURL * url = [NSURL URLWithString:urlString];
        
        // Creating local variable for how to create URL sessions
        // Uses default session configuration on the iPhone
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        // Delegate queue can be helpful if you care about what process or queue you run on
        // We just want to use the main thread (ALL UI must occur on main thread)
        // This is the URL session that we will use to send and receive data
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        // Created data task, used for getting data from a URL
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
        
        // Tell the data task to run
        [dataTask resume];
        
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NSURLSessionDelegate


// Created these methods, copied from header for NSURLSessionDelegate header, added curly braces to make a method

// Used when we receive data
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    
    // Check to see if receivedData exists
    if(!self.receivedData) {
        // If there is nothing in variable initialize it with received data
        self.receivedData = [[NSMutableData alloc]initWithData:data];
    } else {
        // If it does exist already, append received data
        [self.receivedData appendData:data];
    }
}

// Used when we get an error
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    if (!error) {
        // NSLog(@"Download successful! %@", [self.receivedData description]);
        
        // Puts the data received into mutable arrays and dictionaries
        NSDictionary * jsonResponse = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // Create the Friend object here
        // Check that jsonResponse exists
        if (jsonResponse) {
            
            // Parse through jsonResponse, pull out login, name, avatar_url, repos_url
            
            // Create dictionary objects and put into array,
            // Iterate over the array and create objects ??
            for (NSDictionary* aFriendDictionary in _friends) {
                [self.friends addObject:[Friend friendWithDictionary:aFriendDictionary]];
            }
            
            [self.FriendDetailTableView reloadData];
            
            //[self.tableView reloadData];
        }
        
    
        NSLog(@"%@", [jsonResponse description]);
    }
}

// Jeff's gist for didReceiveResponse
// didReceiveResponse implementation
// Some usernames to lookup: slgraff, jtligon, oshort, donnywdavis
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendDetailTableView" forIndexPath:indexPath];
    
    // Get handle to Friend object
    Friend *aFriend = [self.friends objectAtIndex: indexPath.row];
    
    // Set cell text to description
    cell.textLabel.text = aFriend.friendLogin;
    cell.detailTextLabel.text = aFriend.friendName;
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
        
        [self.friends removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}





@end
