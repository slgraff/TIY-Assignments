//
//  TimeCircuitsViewController.swift
//  OutaTimeSwift
//
//  Created by Steve Graff on 5/12/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

// Somewhere in this file I need to adopt the protocol and implement the delegate to retrieve the date and dismiss the DestinationViewController 
// didPickDestinationDate

class TimeCircuitsViewController: UIViewController, DestinationViewControllerDelegate {
    
    @IBOutlet weak var destinationTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    let dateFormatter = NSDateFormatter()
    
    // Declare timer
    var aTimer = NSTimer()
    
    // Declare currentSpeed
    var currentSpeed = 0
    
    // delegate property
    weak var delegate:DestinationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set title for view controller
        self.title = "Time Circuits"
        
        // Initialize the date formatter
        dateFormatter.dateFormat = "MMM dd yyyy"  // MMM tells it to use 3-char month
        
        // Set Present Time label to today's date
        let todaysDate = NSDate()
        let todaysDateString = dateFormatter.stringFromDate(todaysDate)
        self.presentTimeLabel.text = todaysDateString

        // Set Speed label
        speedLabel.text = "\(currentSpeed) MPH"
        
        // Initialize Last Departed Time
        self.lastTimeDepartedLabel.text = "--- -- ----"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func destinationTimeDatePickerAction(sender: AnyObject) {
        destinationTimeDatePicker.datePickerMode = UIDatePickerMode.Date
        
        
        let selectedDestinationDate = dateFormatter.stringFromDate(destinationTimeDatePicker.date)
        
        self.destinationTimeLabel.text = selectedDestinationDate
    }


    
    func didPickDestinationDate(pickedDate: NSDate) {
        self.destinationTimeLabel.text = dateFormatter.stringFromDate(pickedDate)
    }
    
    // MARK: Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "destinationTimeSegue" {
            let destinationVC = segue.destinationViewController as! DestinationViewController
            
            destinationVC.delegate = self
        }
    }
    
    // MARK: Action handlers
    
    @IBAction func travelBackButton(sender: AnyObject) {
        // When clicking Travel Back button call the startTimer function
        startTimer()
    }
    
    func startTimer() {
        // Check if there is already a timer
        if (!aTimer.valid) {
            // If no timer, create one
            aTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateSpeed", userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        // Invalidate (stop) the timer
        aTimer.invalidate()
        
    }
    
    func updateSpeed() {
        if (currentSpeed < 88) {
            currentSpeed += 1
            self.speedLabel.text = "\(currentSpeed) MPH"
        } else if (currentSpeed >= 88) {
            stopTimer()
            lastTimeDepartedLabel.text = presentTimeLabel.text
            presentTimeLabel.text = destinationTimeLabel.text
            speedLabel.text = "0 MPH"
            currentSpeed = 0
        }
    }
    

}

