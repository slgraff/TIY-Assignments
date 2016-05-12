//
//  TimeCircuitsViewController.swift
//  OutaTimeSwift
//
//  Created by Steve Graff on 5/12/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController {
    
    @IBOutlet weak var destinationTimeDatePicker: UIDatePicker!
    
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set title for view controller
        self.title = "Time Circuits"
        
        // Initialize the date formatter
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        
        // Set Present Time label to today's date
        let todaysDate = NSDate()
        let todaysDateString = dateFormatter.stringFromDate(todaysDate)
        self.presentTimeLabel.text = todaysDateString

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func destinationTimeDatePickerAction(sender: AnyObject) {
        destinationTimeDatePicker.datePickerMode = UIDatePickerMode.Date
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDestinationDate = dateFormatter.stringFromDate(destinationTimeDatePicker.date)
        
        self.destinationTimeLabel.text = selectedDestinationDate
 
    }

    @IBAction func travelBackButton(sender: AnyObject) {
        
        
    }
}
