//
//  PopoverLocationViewController.swift
//  DudeWheresMyCar
//
//  Created by Steve Graff on 5/16/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

protocol PopoverLocationViewControllerDelegate: class {
    func setCarLocationName(carLocationName: String)
}

class PopoverLocationViewController: UIViewController {

    @IBOutlet weak var carLocationTextField: UITextField!
    
    var delegate: PopoverLocationViewControllerDelegate?
    var carLocationName: String = ""
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "showPopover") {
//            let destination = segue.destinationViewController as! PopoverLocationViewController
//            destination.delegate = self
//            
//        }
//    }
    
    @IBAction func carLocationSaveButton(sender: UIButton) {
        carLocationName = carLocationTextField.text!
        delegate?.setCarLocationName(carLocationName)
    }
    

}
