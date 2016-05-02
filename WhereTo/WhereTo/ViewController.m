//
//  ViewController.m
//  WhereTo
//
//  Created by Steve Graff on 4/27/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "ViewController.h"
#import "Landmark.h"
#import <MapKit/MapKit.h>  // Use brackets <> when importing frameworks
#import "locationPopoverController.h"

@interface ViewController () <CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate>

// Set property for our map kit view
@property (strong, nonatomic) MKMapView * mapView;
@property (strong, nonatomic) CLLocationManager *manager;  // declare to be strong so it sticks around

// popover view controller
- (IBAction)addLocationsButtonTapped:(id)sender;
- (IBAction)dismissMe:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // CGRect is a struct, a container object with values in it
    // Rects are measured & expressed in points, not pixels
    // Rect of a ViewController is read-only, cannot be changed
    CGRect theFrame = self.view.frame;
    theFrame.origin.x = 20;
    theFrame.origin.y = 94;
    theFrame.size.width -= 40;
    theFrame.size.height -= 114;
    
    // Add '+' bar button item to nav controller
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                  action:@selector(addLocationsButtonTapped:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    

    
    // Create instance of CLLocationManager
    // Need to add NSLocationAlwaysUsageDescription to Info.plist
    CLLocationManager *manager = [[CLLocationManager alloc]init];
    
    self.manager = manager;  // save the local variable manager to class variable

    
    // Request to use location manager
    [manager requestAlwaysAuthorization];
    
    self.mapView = [[MKMapView alloc]initWithFrame:theFrame];
    
    // Enable show user location
    self.mapView.showsUserLocation = YES;
    
    // Must access for permission to get current location
    // When in use, or always on
//    -[CLLocationManager requestWhenInUseAuthorization]
//    -[CLLocationManager requestAlwaysAuthorization]
    
    // put mapView onto the ViewController
    [self.view addSubview:self.mapView];
    
    // Create a landmark object for the capital building
    // Structs from ObjC have initialization function for coordinates, contains 'make'
    Landmark * capitalBuilding = [[Landmark alloc]initWithCoord:CLLocationCoordinate2DMake(35.7804, -78.6391) title:@"Capital Building" subtitle:@"The place where the capital is"];
    
    // Add capital building to the map
    [self.mapView addAnnotation:capitalBuilding];
    
    self.manager.delegate = self;
    [self.manager startUpdatingLocation];
    
    
    // Create a locaiton object for the locaiton of the state capital
    CLLocation * capitalLocation = [[CLLocation alloc]initWithLatitude:capitalBuilding.coordinate.latitude longitude:capitalBuilding.coordinate.longitude];
    
    // Create a location object for current location
    // Can take a while to get current location
    CLLocation * currentLocation = self.mapView.userLocation.location;
    
    // Call our function zoomMapToRegionToRegionEncapsulatingLocation
    if (capitalLocation && currentLocation) {
        [self zoomMapToRegionToRegionEncapsulatingLocation:capitalLocation andLocation:currentLocation];

    }
    
}


#pragma mark - Example mapping methods

// Example methods to manipulate points on a map
// (Would generally want to perform this businesss logic in its own class file)

-(void)centerMapOnLocation:(CLLocationCoordinate2D)location{
    
}

-(void)zoomMapToRegionToRegionEncapsulatingLocation:(CLLocation *)firstLoc andLocation:(CLLocation *)secondLoc {
    
    
    float latitude = (firstLoc.coordinate.latitude + secondLoc.coordinate.latitude) /2;
    float longitude = (firstLoc.coordinate.longitude + secondLoc.coordinate.longitude) /2;
    
    // Determined distance between two locations
    CLLocationDistance distance = [firstLoc distanceFromLocation:secondLoc] / 111.0f;
    
    
    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    MKCoordinateSpan span = MKCoordinateSpanMake(2000, 2000);
    
    if (CLLocationCoordinate2DIsValid(centerLocation.coordinate)) {
        
        MKCoordinateRegion region = MKCoordinateRegionMake(centerLocation.coordinate, span);

        // Zoom to our region with zoom with animation
        [self.mapView setRegion:region animated:YES];
    }
    
    

    
}

#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation * firstLocation = [locations firstObject];
    CLLocation * lastLocation = [locations lastObject];
    
    if ( [firstLocation isEqual:lastLocation]) {
        NSLog(@"same place!");
    } else {
        NSLog(@"who knows?");
    }
    
    // Create a landmark object for the capital building
    // Structs from ObjC have initialization function for coordinates, contains 'make'
    Landmark * capitalBuilding = [[Landmark alloc]initWithCoord:CLLocationCoordinate2DMake(35.7804, -78.6391) title:@"Capital Building" subtitle:@"The place where the capital is"];
    
    CLLocation * capitalLocation = [[CLLocation alloc]initWithLatitude:capitalBuilding.coordinate.latitude longitude:capitalBuilding.coordinate.longitude];
    
    
    [manager stopUpdatingLocation];
}


// Implementation for popover controller
-(IBAction) addLocationsButtonTapped:(id)sender {
    LocationPopoverController *controller = [[LocationPopoverController alloc]init];
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    // Create instance of UIPopoverPresentationController
    UIPopoverPresentationController *popoverController = [controller popoverPresentationController];
    popoverController.permittedArrowDirections = UIPopoverArrowDirectionAny; // Sets where the 'arrow' is attached to
    popoverController.barButtonItem = sender;
    popoverController.delegate = self; // This class controls the delegation for the popover
    
    [self presentViewController:controller animated:YES completion:nil];
}

// Add a new view controller
- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style {
    
    // Create navigation controller
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller.presentedViewController];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                  target:self
                                  action:@selector(dismissMe:)];
    navController.navigationBar.topItem.rightBarButtonItem = doneButton;
    return navController;
}

// DismissMe method
- (IBAction)dismissMe:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
