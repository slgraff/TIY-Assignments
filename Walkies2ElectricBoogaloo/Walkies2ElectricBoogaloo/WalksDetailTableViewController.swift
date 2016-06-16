//
//  WalksDetailTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

class WalksDetailTableViewController: UITableViewController {

    var walk: Walks?
    var managedObjectContext: NSManagedObjectContext!
    

    @IBOutlet weak var walkClientLabel: UILabel!
    @IBOutlet weak var walkTimeTextField: UITextField!
    @IBOutlet weak var walkNotesTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let walk = walk {
            walkTimeTextField.text = String(walk.walkDate!)
            walkNotesTextField.text = walk.notes
            
            if let client = walk.client {
                walkClientLabel.text = "Client: \(client.name)"
            } else {
                walkClientLabel.text = "Choose client"
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        // Need to add a walk?
        if walk == nil {
            if let walkTime = walkTimeTextField.text, walkNotes = walkNotesTextField.text, entity = NSEntityDescription.entityForName("Walks", inManagedObjectContext: managedObjectContext) where !walkTime.isEmpty && !walkNotes.isEmpty {
                
                
                // Get current date
                let currentDate = NSDate()
//                let dateFormatter = NSDateFormatter()
//                dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
//                let currentDateString = dateFormatter.stringFromDate(currentDate)
                
                walk = Walks(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
                walk?.walkDate = String(currentDate)
                walk?.notes = "Enter any notes"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let clientPicker = storyboard?.instantiateViewControllerWithIdentifier("Clients") as? ClientsTableViewController {
                clientPicker.managedObjectContext = managedObjectContext
                clientPicker.pickerDelegate = self
                clientPicker.selectedClient = walk?.client
                
                navigationController?.pushViewController(clientPicker, animated: true)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}


extension WalksDetailTableViewController: ClientPickerDelegate {
    func didSelectClient(client: Clients) {
    walk?.client = client
    
    do {
        try managedObjectContext.save()
        } catch {
            print("Error saving the managed object context!")
        }
    }
}
