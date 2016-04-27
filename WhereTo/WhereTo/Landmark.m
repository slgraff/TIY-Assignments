//
//  Landmark.m
//  WhereTo
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "Landmark.h"

@implementation Landmark

// Implementation of instance method
-(nullable instancetype)initWithCoord:(CLLocationCoordinate2D)coord
                                title:(nullable NSString*) titleString
                             subtitle:(nullable NSString*) subtitleString {
    
        self = [super init];
        if (self) {
            _coordinate = coord;
            _title = titleString;
            _subtitle = subtitleString;
        }
        return self;
}


@end
