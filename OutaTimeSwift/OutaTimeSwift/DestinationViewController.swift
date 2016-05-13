
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

// Definition of optional delegate property
weak var delegate:DestinationViewControllerDelegate?

// Definition of delegate protocol
protocol DestinationViewControllerDelegate: class {
    func didPickDestinationDate(sender: DestinationViewController)
}


class DestinationViewController:UIViewController {
    
    @IBAction func destinationTimeDatePickerAction(sender: AnyObject) {
    }
}