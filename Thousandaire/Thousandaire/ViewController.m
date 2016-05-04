//
//  ViewController.m
//  Thousandaire
//  In class assignment - fill an array with 1000 numbers
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Declare the arrays
@property NSMutableArray *numberArray;
@property NSMutableArray *randomArray;


// Declare the Thousandaire method
-(void)Thousandaire;

// Declare the Ramdomaire method
-(void)Randomaire;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self Thousandaire];
    
    [self Randomaire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Thousandaire {
    // Implement the array
    self.numberArray = [[NSMutableArray alloc]init];
    
    for(int i = 1; i <=1000; i += 1) {
        [self.numberArray addObject:[NSNumber numberWithInt:i]];
        NSLog(@"%d", i);
    }
    
    
    
    NSLog(@"Count of numbers in array: %lu", (unsigned long)[self.numberArray count]);
    
    
}

// Declare the Ramdomaire method
-(void)Randomaire {
    // Implement the array
    self.randomArray = [[NSMutableArray alloc]init];
    
    int theCount = 1;
    NSNumber *largestNum;
    
    // Repeat 1000 times
    // I have no idea what I'm doing
    while (theCount <= 1000) {
        [self.randomArray addObject:[NSNumber numberWithUnsignedInteger:arc4random_uniform(1000)+ 1]];
        
        theCount += 1;
    }
        
    
    NSLog(@"Count of numbers in array: %lu", (unsigned long)[self.randomArray count]);

    // ways to get largest element in array
    // sort array, get last element
    
    
    // scanning for highest value
    for (int i = 0; i < self.randomArray.count ; i += 1) {
        NSNumber *largestNum = [[NSNumber alloc]init];
        
        if (self.randomArray[i] > largestNum) {
            largestNum = self.randomArray[i];
        }
    }
    
    // Print out largest found number
    NSLog(@"The largest number in randomArray is: %ld", (long)[largestNum integerValue]);
    
    
    
    // Jeff's array of random numbers
    NSMutableArray *secondArray = [NSMutableArray array];
    while (secondArray.count < 1000) {
        secondArray[secondArray.count] = [NSNumber numberWithUnsignedInteger:arc4random_uniform(100)];
    }
    
    
    // Can use sort descriptor to sort Jeff's array
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"intValue" ascending:YES];
    NSArray *sortDescriptors = @[sortDesc];
    [self.randomArray sortUsingDescriptors:sortDescriptors];
    NSLog(@"The last object %@", [self.randomArray lastObject]);
    
    // Q: What is the most unique numbers you can have in array
    // A: 100 (the number of elements in array)
    
    // Q: What is the least unique numbers you can have in array
    // A: 0 (each number could be repeated in array, i.e. none are unique)
    
    // How to determine number of times each time a number occurs in array?
    // Use a histogram
    
    NSDate * start = [NSDate date];
    
    // Jeff's solution to producing a histogram
    int array[100] = {};  // Used a dirty C trick, declared an array of 100 ints, initialized to 0
    for (int i = 0;i < 1000; i++) {
        array[[secondArray[i] integerValue] ]++;
    }
    
    NSDate * end = [NSDate date];
    
    NSTimeInterval interval = [end timeIntervalSinceDate:start];
    NSLog(@"time %f", interval);
    
    NSLog(@"%lu", (unsigned long)secondArray.count);
    
    // Using NSCountedSet to get count of each element in array
    NSCountedSet *set = [[NSCountedSet alloc]initWithArray:secondArray];
    NSLog(@"%@", set); // print out the set
    
    
    // Print out the number, frequency
//    for (id item in set) {
//        NSLog(@"Number: %@, Count: %lu", item, (unsigned long)[set countForObject:item]);
//    }
}





@end




