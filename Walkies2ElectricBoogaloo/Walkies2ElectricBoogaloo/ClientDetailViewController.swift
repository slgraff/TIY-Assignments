//
//  ClientDetailViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

class ClientDetailViewController: UIViewController {

    
    var client: Clients?
    var managedObjectContext: NSManagedObjectContext!


    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientAddressLabel: UILabel!
    @IBOutlet weak var clientPhoneLabel: UILabel!
    @IBOutlet weak var clientEmailLabel: UILabel!
    
    @IBOutlet weak var clientSecurityInfoLabel: UILabel!
    @IBOutlet weak var clientNotesTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Populate info about client
        if let client = client {
            clientNameLabel.text = "\(client.name)"
            clientAddressLabel.text = "\(client.address)"
            clientPhoneLabel.text = "\(client.phone)"
            clientEmailLabel.text = "\(client.email)"
            
            clientSecurityInfoLabel.text = "\(client.securityInfo)"
            clientNotesTextView.text = "\(client.notes)"
            
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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