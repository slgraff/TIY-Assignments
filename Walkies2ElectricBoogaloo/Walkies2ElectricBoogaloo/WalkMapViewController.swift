//
//  WalkMapViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import CoreLocation


class WalkMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    
    var walk: Walks?
    var walkMapSnapshotURL: String?

    @IBOutlet weak var walkMapView: MKMapView!
    @IBOutlet weak var walkButton: UIButton!
    @IBOutlet weak var walkTimeLabel: UILabel!
    
    var locationManager: CLLocationManager!
    var locations = [CLLocation]()
    
    var walkDurationTimer = NSTimer()
    var updateLocationTimer = NSTimer()
    var walkDurationInSeconds = 0
    
    
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
    
    override func viewWillDisappear(animated: Bool) {
        // TODO: What do I need to do when this view controller disappears?
        // - Pass value of walkDurationInSeconds, or just write to database (setup attribute for this)
        // - Pass a snapshot of the map with overlay, or just save this to database
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Toggle tracking users walk on/off
    @IBAction func walkButtonTapped(sender: AnyObject) {
        
        if walkButton.titleLabel!.text == "Start Walk" {
            locationManager.startUpdatingLocation()
            startWalkTimer()
            walkButton.setTitle("Stop Walk", forState: .Normal)
        } else if walkButton.titleLabel!.text == "Stop Walk" {
            locationManager.stopUpdatingLocation()
            stopWalkTimer()
            walkButton.setTitle("Start Walk", forState: .Normal)
            createVCScreenShot() // Save screen shot of view to Documents, save URL to store
            createScreenShot()  // Saves to photo library
            createMapSnapshot() // Saves to Documents on device file system

        }
    }
    
    func startWalkTimer() {
        walkDurationTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(WalkMapViewController.incrementTimer), userInfo: nil, repeats: true)
    }
    
    func stopWalkTimer() {
        walkDurationTimer.invalidate()
    }
    
    func incrementTimer() {
        walkDurationInSeconds += 1
        let (walkMins, walkSecs) = secondsToMinutesSeconds(walkDurationInSeconds)
        walkTimeLabel.text = String(format:"%02d:%02d", walkMins, walkSecs)
    }
    
    func secondsToMinutesSeconds (seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }
    
    
    func createMapSnapshot() {
        let options = MKMapSnapshotOptions()
        options.region = walkMapView.region
        options.size = walkMapView.frame.size
        options.scale = UIScreen.mainScreen().scale
        
        let fileURL = NSURL(fileURLWithPath: "\(getPathToDocumentsDirectory())")  // TODO: Set path to save file
        
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.startWithCompletionHandler { snapshot, error in
            guard let snapshot = snapshot else {
                print("Snapshot error: \(error)")
                return
            }
            
            let data = UIImagePNGRepresentation(snapshot.image)
            data?.writeToURL(fileURL, atomically: true)
        }
    }

    func getPathToDocumentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // MARK: Location Manager Delegate Methods
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // TODO: Do I need to do anything here??
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Oh 💩! Some one set up us the bomb: \(error)")
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
            
            // TODO: Always track user location, or at set duration?
            // every minute, 5 minutes, etc.
//            locationManager.stopUpdatingLocation()
//            updateLocationTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: locationManager, selector: #selector(locationManager.startUpdatingLocation), userInfo: nil, repeats: false)
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
    
    
    // MARK: CreateScreenShot Method
    // Relies on access to user's photo library
    func createScreenShot() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
    
    // MARK: CreateVCScreenShot method
    func createVCScreenShot() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Get path to device Documents folder
        let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory: NSString = paths.objectAtIndex(0) as! NSString
        
        // Create a date string to use as unique file name for image
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let now: NSDate = NSDate(timeIntervalSinceNow: 0)
        let theDate: NSString = dateFormat.stringFromDate(now)
        
        // Append walk client info to string
        theDate.stringByAppendingString(walk!.client!.name!)
        
        // Save data to documents directory
        self.walkMapSnapshotURL = NSString(format: "/%@.png", theDate) as String
        let fullPath:NSString = documentsDirectory.stringByAppendingString(self.walkMapSnapshotURL!)
        let pngData: NSData = UIImagePNGRepresentation(screenshot)!
        pngData.writeToFile(fullPath as String, atomically: true)
        
        // Save picture URL to core data
        walk?.walkMapSnapshotURL = self.walkMapSnapshotURL
        
        saveContext()
    }
    
    
    // MARK: - Core Data Save support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
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
