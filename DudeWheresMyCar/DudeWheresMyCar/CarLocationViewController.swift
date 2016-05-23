//
//  CarLocationViewController.swift
//  DudeWheresMyCar
//
//  Created by Steve Graff on 5/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreLocation // Added to allow use of CoreLocation in app
import MapKit // Added to allow use of MapKit in app



class CarLocationViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate,UIPopoverPresentationControllerDelegate, PopoverLocationViewControllerDelegate {  // Make VC conform to delegates for CoreLocation, MapView, UIPopoverPresentationControllerDelegate

    // MARK: Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dropPinButton: UIBarButtonItem!
    
    var locationName: String = ""
    var locationDict = Dictionary<String, AnyObject>()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Dude, where's my car?"
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Requesting 'When in use' never works in this app. Wtf?
        // self.locationManager.requestWhenInUseAuthorization()
        
        // Requesting 'always' auth always works
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        self.mapView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Drop Pin
    @IBAction func dropPinButton(sender: AnyObject) {
        
        self.performSegueWithIdentifier("showPopover", sender: self)
        

        
    }
    
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Perform specific stuff for our popover
        if segue.identifier == "showPopover" {
            
            let vc = segue.destinationViewController as? PopoverLocationViewController
            vc?.delegate = self
//            
//            let controller = vc.popoverPresentationController
//            
//            if controller != nil {
//                controller!.delegate = self
//            }
        }
    }
    
    
//    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
//        print("Returned from popover")
//    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .None
    }
    
    
    
    
//    @IBAction func getLocation() {
//        
//        // Ask to get users location
//        let authStatus = CLLocationManager.authorizationStatus()
//        if authStatus == .AuthorizedWhenInUse {
//            print("we have authorization")
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//            return
//        }
//        
//        
//        // locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.startUpdatingLocation()
//    }
    
    // MARK: CLLocationManagerDelegates
    
    // Did Change Authorization Status
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("Location status changed")
    }
    
    // Did Fail With Error
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("didFailWithError \(error)")
    }
    
    // Did Update Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")

        let center = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(region, animated: true)
    }
    
    
    func setCarLocationName(carLocationName: String) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        // self.navigationController?.popViewControllerAnimated(true)

        locationName = carLocationName
        
        // Drop pin on map at current location
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude)
        annotation.title = carLocationName
        self.mapView.addAnnotation(annotation)
        
        // Save this location to NSUserDefaults
        
        // We have our coordinates stored in annotation.coordinate
        let carLat = NSNumber(double: annotation.coordinate.latitude)
        let carLon = NSNumber(double: annotation.coordinate.longitude)
        
        // Need to add a 'name' key/value pair to hold data passed back from popup view controller
        let locationDict = ["name": locationName, "lat": carLat, "long": carLon]
        // let locationDict = ["lat": carLat, "long": carLon]
        NSUserDefaults.standardUserDefaults().setObject(locationDict, forKey: "CarLocation")
    }
    
    
    // MARK: NSCoding
    
    func saveCar() {
    
        // This is where to save the car to file system
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(locationDict, toFile: Car.ArchiveURL.path!)
        if !isSuccessfulSave {
            print("Failed to save car...")
        }
    }
    
    // MARK: MKMapView Delegates
    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        if (annotation is MKUserLocation) {
//            return nil
//        }
//        
//    }
}

