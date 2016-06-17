//
//  WalkMapViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class WalkMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var walkMapView: MKMapView!
    @IBOutlet weak var walkButton: UIButton!
    @IBOutlet weak var walkTimeLabel: UILabel!
    
    var locationManager: CLLocationManager!
    var locations = [CLLocation]()
    
    var updateLocationTimer = NSTimer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        // Ask for authorization to access user location always
        let locationAuthStatus = CLLocationManager.authorizationStatus()
        if locationAuthStatus == .NotDetermined || locationAuthStatus == .Denied || locationAuthStatus == .AuthorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
        
        // Get current location
        locationManager.requestLocation()
        
        // Setup MapView to show user location
        walkMapView.delegate = self
        walkMapView.showsUserLocation = true
        walkMapView.mapType = MKMapType.Standard
        walkMapView.userTrackingMode = MKUserTrackingMode.Follow
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Toggle tracking users walk on/off
    @IBAction func walkButtonTapped(sender: AnyObject) {
        
        if walkButton.titleLabel!.text == "Start Walk" {
            locationManager.startUpdatingLocation()
            walkButton.setTitle("End Walk", forState: .Normal)
        } else if walkButton.titleLabel!.text == "Stop Walk" {
            locationManager.stopUpdatingLocation()
            walkButton.setTitle("Start Walk", forState: .Normal)
        }
    }

    // MARK: Location Manager Delegate Methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // TODO: Do I need to do anything here??
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Some one set up us the bomb: \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locations.append(locations[0] as CLLocation)
        
        // Setup showing poly overlay for walked route
        if (self.locations.count > 1) {
            let sourceIndex = self.locations.count - 1
            let destinationIndex = self.locations.count - 1
            
            let firstCoordinate = self.locations[sourceIndex].coordinate
            let secondCoordinate = self.locations[destinationIndex].coordinate
            var routeCoordinates = [firstCoordinate, secondCoordinate]
            let walkRoutePolyline = MKPolyline(coordinates: &routeCoordinates, count: routeCoordinates.count)
            
            walkMapView.addOverlay(walkRoutePolyline)
            
            // TODO: Determine if we want to always track user location
            // or only at certain intervals (every minute, 5 minutes, etc.)
            locationManager.stopUpdatingLocation()
            updateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(locationManager.startUpdatingLocation), userInfo: nil, repeats: false)
        }
    }
    
    
    // MARK: Map View Delegate Methods
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        
        if (overlay is MKPolyline) {
            let polyRenderer = MKPolylineRenderer(overlay: overlay)
            polyRenderer.strokeColor = UIColor.blueColor()
            polyRenderer.lineWidth = 5
            return polyRenderer
        }
        return MKPolylineRenderer()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
