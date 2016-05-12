//
//  main.m
//  NumberStuff
//
//  Created by Steve Graff on 5/11/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberStuff-Swift.h"  // Name of product + -Swift.h
#import "NumberStuff.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        NumberWrapper *wrapper = NumberWrapper.new;
        [wrapper passThroughArray];
        
        [NumberWrapper justTheValues];
        
    }
    
    
    return 0;
}
