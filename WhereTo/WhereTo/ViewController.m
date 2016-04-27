//
//  ViewController.m
//  WhereTo
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>  // Use brackets <> when importing frameworks

@interface ViewController ()

// Set property for our map kit view
@property (strong, nonatomic) MKMapView * mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // CGRect is a struct, a container object with values in it
    // rects are measured & expressed in points, not pixels
    // rect of a ViewController is read-only, cannot be changed
    CGRect theFrame = self.view.frame;
    theFrame.origin.x = 20;
    theFrame.origin.y = 94;
    theFrame.size.width -= 40;
    theFrame.size.height -= 114;
    
    self.mapView = [[MKMapView alloc]initWithFrame:theFrame];
    
    // put mapView onto the ViewController
    [self.view addSubview:self.mapView];
    
    // Create a landmark
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
