
//
//  DestinationViewController.swift
//  OutaTimeSwift
//
//  Created by Steve Graff on 5/12/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation
import UIKit

// Somewhere in this file I need to declare a @property for the delegate method that will receive the picked date
// didPickDestinationDate ??



// Definition of delegate protocol
protocol DestinationViewControllerDelegate: class {
    func didPickDestinationDate(pickedDate: NSDate)

}


class DestinationViewController:UIViewController {
    
    // Definition of optional delegate property
    weak var delegate:DestinationViewControllerDelegate?
    
    @IBOutlet var destinationDatePicker: UIDatePicker!
    
    override func viewWillDisappear(animated: Bool) {
        // Tell our delegate to perform it's function
        delegate?.didPickDestinationDate(destinationDatePicker.date)
    }

}

