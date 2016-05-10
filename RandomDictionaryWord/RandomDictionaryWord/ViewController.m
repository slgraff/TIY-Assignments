//
//  ViewController.m
//  RandomDictionaryWord
//
//  Created by Steve Graff on 5/9/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // Create NSURL for Random Word service on SetGetGo
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://randomword.setgetgo.com/get.php?len=5"]];
    
    // use default session configuration on the device
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Set to use main thread
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    // Create data task
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL: url];
    
    [dataTask resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
