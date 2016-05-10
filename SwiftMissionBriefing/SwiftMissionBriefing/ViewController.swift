//
//  ViewController.swift
//  SwiftMissionBriefing
//
//  Created by Steve Graff on 5/10/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var agentNameTextField: UITextField!
    @IBOutlet weak var agentPasswordTextField: UITextField!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var missionGreetingTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize Agent Name, Agent Password and Greeting Label and Greeting Text to be empty
        agentNameTextField.text = ""
        agentPasswordTextField.text = ""
        greetingLabel.text = ""
        missionGreetingTextView.text = ""
        
        // Set Agent Name field to be first responder
        agentNameTextField.isFirstResponder()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: Authenticate Agent
    @IBAction func authenticateButton(sender: AnyObject) {
        
        var lastName: String
        
        // Dismiss keyboard when authenticate button tapped
        if (agentNameTextField.isFirstResponder()) {
            agentNameTextField.resignFirstResponder()
        }
        
        // Ensure both text fields have contents
        if (agentNameTextField.text != "" && agentPasswordTextField.text != "") {
            
            // Grab the agent name, parse out the last name
            let agentName = agentNameTextField.text
            
            // Check for number of 'words' in agent name
            if (agentName!.componentsSeparatedByString(" ").count > 1) {
                lastName = (agentName!.componentsSeparatedByString(" ")[1])
            } else {
                lastName = agentName!
            }
            
           
            // Create the agnet greeting using last name, display in label
            greetingLabel.text = "Good Evening, Agent \(lastName)"
            
            // Use string interpolation to insert agentName into mission greeting text
            missionGreetingTextView.text = "This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent \(lastName), you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds."
            
            // Upon successful login, set background color to green
            view.backgroundColor = UIColor.greenColor()
            
        } else {
            
            // Upon failed login, set background color to red
            view.backgroundColor = UIColor.redColor()

        }
    }
}

