//
//  MasterViewController.swift
//  RecSportSwim
//
//  Created by Steve Graff on 5/31/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import Firebase

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    // Declare dictionary to hold swim meet data
    var meetData:[String:[String:String]] = Dictionary()
    
    // Firebase services
    var database: FIRDatabase!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize navigation bar
        self.title = "Upcoming Meets"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(createNewMeet(_:)))
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        
        // MARK: Initilize Firebase Database
        database = FIRDatabase.database()
        
        let ref = database.reference().child("meets")
        ref.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            // Get the meets from the snapshot and add to the UI
            if let data = snapshot.value as? [String:[String:String]] {
                print(data)
                self.meetData = data
            } else {
                print("Someone set us up the bomb")
            }
            self.tableView.reloadData()
            })
            

// TODO: Do I need to also setup an observeEventType to check for changes to data and update as needed?
        
//        _ = self.ref!.child("recsportswim").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
//            if let postDict = snapshot.value as? [String : String] {
//                self.objects = Array<String>(postDict.values)
//                print(self.objects)
//                // Reload the tableView after making above changes
//                self.tableView.reloadData()
//            }
//        })

        
        
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Create New Meet
    func createNewMeet(sender: AnyObject) {

//        // Make a unique string
//        let rangeOfInts = [Int](65...91)
//        let rangeOfChars:Array<Character> = rangeOfInts.map { value in
//            return Character(UnicodeScalar(value))
//        }
//        
//        var uniqueString = ""
//        for _ in 1...10 {
//            let random = arc4random_uniform(UInt32(rangeOfChars.count))
//            uniqueString.append(rangeOfChars[Int(random)])
//        }
//        
//        objects.insert(uniqueString, atIndex: 0)
        
        // Store the string into the Firebase database
//        let newUniqueWordLocation = self.ref?.child("meets").childByAutoId()
//        newUniqueWordLocation?.setValue(uniqueString)
//        
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
    }
    

     // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                var meetKeysArray = Array(meetData.keys)
                meetKeysArray.sortInPlace()
                
                let meet = meetData[meetKeysArray[indexPath.row]]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = meet
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Parse out swim meet from meetData, populate fields
        var meetKeysArray = Array(meetData.keys)
        meetKeysArray.sortInPlace()
        
        cell.textLabel!.text = meetData[meetKeysArray[indexPath.row]]!["date"]! + " - " + meetData[meetKeysArray[indexPath.row]]!["time"]!
        
        let opposingTeamTitle = meetData[meetKeysArray[indexPath.row]]!["opposing_team"]!
        cell.detailTextLabel!.text = "Meet against the \(opposingTeamTitle)"
        
        return cell
    }
    

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }


}

