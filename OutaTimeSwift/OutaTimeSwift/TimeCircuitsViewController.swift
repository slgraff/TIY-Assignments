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

//extension ViewController: DestinationViewControllerDelegate {
//    func didDismissDestinationVC(sender: DestinationViewController) {
//        status = sender.status
//        dismissViewControllerAnimated(true, completion: nil)
//        configureView()
//    }
//}

class TimeCircuitsViewController: UIViewController, DestinationViewControllerDelegate {
    
    @IBOutlet weak var destinationTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    let dateFormatter = NSDateFormatter()
    
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

        // Initialize Current Speed, set Speed label
        var currentSpeed = 0
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

    @IBAction func travelBackButton(sender: AnyObject) {
    
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

}

