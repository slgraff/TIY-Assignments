//
//  Landmark.h
//  WhereTo
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Landmark : NSObject <MKAnnotation>

// CLLocationCoordinate2D is a read-only struct, contains latitude and longitude
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

// Title and subtitle are also read-only structs
@property (nonatomic, readonly, copy, nullable) NSString *title;
@property (nonatomic, readonly, copy, nullable) NSString *subtitle;

// Declare a custom initializer
-(nullable instancetype)initWithCoord:(CLLocationCoordinate2D)coord title:(nullable NSString*) titleString subtitle:(nullable NSString*) subtitleString;

@end
