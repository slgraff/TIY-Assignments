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
#import "LocationPopoverController.h"

@interface ViewController () <CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate>

// Set property for our map kit view
@property (strong, nonatomic) MKMapView * mapView;
@property (strong, nonatomic) CLLocationManager *manager;  // declare to be strong so it sticks around
@property (strong, nonatomic) UIViewController * insideViewController;

// popover view controller
- (IBAction)addLocationsButtonTapped:(id)sender;  // declare method for pressing '+' button
- (IBAction)dismissMe:(id)sender; // declare method for dismiss button in controller



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
                                  action:@selector(addLocationsButtonTapped:)]; //
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


// Implementation for action tapping addLocationsButtonTapped
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


// Added during 5/2 lecture
// Need to declare controller at top of file??
-(UIViewController *)controllerForInsidePopover {
    UIViewController * createMeNow = [[UIViewController alloc]init];
    
    createMeNow.view.backgroundColor = UIColor.whiteColor;
    
    // Add first text field
    UITextField * firstText = [[UITextField alloc]initWithFrame:CGRectMake(10, 40, 460, 30)];
    firstText.borderStyle = UITextBorderStyleLine;
    firstText.tag = 5;
    [createMeNow.view addSubview: firstText];
    
    // Add second text field
    UITextField * secondText = [[UITextField alloc]initWithFrame:CGRectMake(10, 80, 400, 30)];
    secondText.borderStyle = UITextBorderStyleLine;
    secondText.tag = 6;

    [createMeNow.view addSubview: secondText];
    
    // Add button
    UIButton * closeMeButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 120, 200, 35)];
    [closeMeButton setTitle:@"CloseMe" forState:UIControlStateNormal];
    [closeMeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [closeMeButton addTarget: createMeNow action:@selector(closePopoverView) forControlEvents: UIControlEventTouchUpInside];
    [createMeNow.view addSubview:closeMeButton]; // add the button to the view
    
    // Need to implement createMeNow
    return createMeNow;
}

// Added during 5/2 lecture
// Need to update for my button and view controller names
-(IBAction)addButtonPressed:(UIBarButtonItem*)sender {
    
    UIViewController* insideViewController = [self controllerForInsidePopover];
    insideViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController * popPresController = [self.insideViewController popoverPresentationController];
    
    // Replaced by above line
    // UIPopoverPresentationController * popPresController = [[UIPopoverPresentationController alloc]initWithPresentedViewController:insideViewController presentedViewController:self];
    
    popPresController.delegate = self;
    popPresController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popPresController.barButtonItem = sender;
    
    [self presentViewController:self.insideViewController animated:YES completion:nil];
    
}

-(void)closePopoverView {
    
    UITextField* firstText = [self.insideViewController.view viewWithTag: 5];
    UITextField* secondText = [self.insideViewController.view viewWithTag: 6];
    
    [self lookupCities:@[firstText.text, secondText.text]];
    
    [self.insideViewController dismissViewControllerAnimated:YES completion:nil];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

// Implement following:
// adaptivePresentationStyleForPresentationController
// presentationController
// popoverPresentationControllerShouldDismissPopover


// Add a new view controller
//- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:insdieViewController.modalPresentationStyle = (UIModal
//    
//    
//    // Create navigation controller
//    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller.presentedViewController];
//    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//                                  target:self
//                                  action:@selector(dismissMe:)];
//    navController.navigationBar.topItem.rightBarButtonItem = doneButton;
//    return navController;
//}

-(void)lookupCities: (NSArray*)cityArray {
    NSAssert2(@"both strings", @"are present", cityArray[0], cityArray[1]); // NSAssert2 checks if objects are not nil

    CLGeocoder * geocoder = [[CLGeocoder alloc]init];
    
    // declare local variables for both locations, used inside our blocks
    __block CLLocationCoordinate2D firstPlace;
    __block CLLocationCoordinate2D secondPlace;
    
    // Create variable for weakSelf, __block makes it a block type
    // Can be used to call a method, need to make sure when using that it is still around
    __block ViewController * weakSelf = self;
    
    [geocoder geocodeAddressString:cityArray[0] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        // Completion handler returns array of CLPlacemarks and an error
        CLPlacemark * placemark = [placemarks lastObject];
        
        firstPlace = placemark.location.coordinate;
    }];
    
    
    // Putting second geocoder request inside dispatch_after block, 2 second wait
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [geocoder geocodeAddressString:cityArray[1] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            // Completion handler returns array of CLPlacemarks and an error
            CLPlacemark * placemark = [placemarks lastObject];
            
            secondPlace = placemark.location.coordinate;
        }];
        
    });
    
    
    // adding 5 second delay before attempting to get locations and add annotations to map
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        Landmark *theFirst = [[Landmark alloc]initWithCoord:firstPlace title:cityArray[0] subtitle:@"The first location"];
        Landmark *theSecond = [[Landmark alloc]initWithCoord:secondPlace title:cityArray[1] subtitle:@"The second location"];
    
        [self.mapView addAnnotations:@[theFirst, theSecond]];

    });
    

    
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
