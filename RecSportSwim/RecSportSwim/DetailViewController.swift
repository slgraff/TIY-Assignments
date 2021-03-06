//
//  DetailViewController.swift
//  RecSportSwim
//
//  Created by Steve Graff on 5/31/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var meetDateLabel: UILabel!
    @IBOutlet weak var meetLocationLabel: UILabel!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item
        if let detail = self.detailItem {
            
            if let dateLabel = self.meetDateLabel, locationLabel = self.meetLocationLabel {
                dateLabel.text = detailItem!["date"] as? String
                locationLabel.text = detailItem!["location"] as? String
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

