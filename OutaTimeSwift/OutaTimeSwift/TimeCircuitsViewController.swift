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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Time Circuits"
        
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

}

