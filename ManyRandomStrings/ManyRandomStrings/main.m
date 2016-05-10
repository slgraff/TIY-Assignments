//
//  main.m
//  ManyRandomStrings
//
//  Code Kata exercise for Mon, May 9
//  Create an array containing 1000 random, unique strings
//  Six characters or longer
//  Bonus points if they are all words
//
//  Created by Steve Graff on 5/9/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>

// Declaration of functions FizzBuzz and Palindrome
void RandomCharacters(void);
void RandomWordFromDictJSON(void);
void RandomWords(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        // And so it begins...
        
        // Iinitialize NSString containg lower and uppoer case letters
        // NSString *letterString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQURTUVWXYZ";
        
        // property for received data
        NSMutableData *receivedData = [[NSMutableData alloc]init];
        
        // Initialize array of strings to hold our generated strings
        NSMutableArray *randomWords = [[NSMutableArray alloc]init];
        

        
        // FAIL!!
        // NSDictionary *dictionaryWords = [NSJSONSerialization JSONObjectWithData: fileData options:NSJSONReadingMutableContainers error:&jsonError];
        
        // NSDictionary *dictionaryWords = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
        
        // Repeat until our array contains 1000 items
        while ([randomWords count] < 1000) {
            
            // Grab a random word from dictionaryWords, check if >= 6 characters

            NSSet *dictKeys = [NSSet setWithArray:[dictionaryWords allKeys]];
            
            while (dictKeys != nil) {
                NSString *randomKey = [dictKeys anyObject];
                [randomWords addObject:([dictionaryWords objectForKey:randomKey])];
            }
            
            
            
            
            }
        }

    NSLog(@"Created array containing %lu random words.", [randomWords count]);
        
        
        /*  Get random word from dictionary web service
         
         
            WordsAPI offers a random=true parameter to return one random word
            Documentation: https://www.wordsapi.com/docs
            BUT: They require credit card on file, even for free account
         
            SetGetGo offers a randomword service, can set length of word
            http://randomword.setgetgo.com/get.php?len=5
        */
        
        
        // ** This code based off of GitHubFriends **
        
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

    void RandomCharacters() {
        int theCount = 1;
        // Repeat 1000 times
        while (theCount <= 1000) {
            
            // Initialize a mutable string to hold our created six char string
            NSMutableString *randomString = [NSMutableString stringWithCapacity:6];
            
            // Create a random string containing six characters, store in array
            for (int numChars = 1; numChars <= 6; numChars += 1) {
                
                [randomString appendFormat: @"%C", [letterString characterAtIndex:arc4random_uniform([letterString length])]];
            }
            
            [randomWords addObject:randomString];
            
            
            theCount += 1;
        }
        NSLog(@"Created array containing %lu six character strings.", (unsigned long)[randomWords count]);
    }

    void RandomWordFromDictJSON() {
        
        /*  DictionaryWordStrings
         Attempt to load a large json file containing dictionary into memory
         Load it into an NSDictionary then grab random words and put into array
         */
        
        NSDictionary *dictionaryWords = [[NSDictionary alloc]init];
        
        // Read in the JSON file
        
        // Create string with filepath to the Characters.json file
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dictionary" ofType:@"json"];
        
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        while (fileData != nil) {
            dictionaryWords = [NSJSONSerialization JSONObjectWithData:fileData options:0 error:nil];
    }
    
    return 0;
}
