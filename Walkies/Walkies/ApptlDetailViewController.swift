//
//  DetailViewController.swift
//  Walkies
//
//  Created by Steve Graff on 6/8/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class ApptDetailViewController: UIViewController {
    
    var appointment: Appointment?
    var managedObjectContext: NSManagedObjectContext!

    @IBOutlet weak var apptClientLabel: UILabel!
    @IBOutlet weak var apptAddressLabel: UILabel!
    @IBOutlet weak var apptDogLabel: UILabel!


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.apptClientLabel {
                label.text = detail.valueForKey("client")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

