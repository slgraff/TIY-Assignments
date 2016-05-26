//
//  MasterViewController.swift
//  Whisper
//
//  Created by Steve Graff on 5/26/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = [String]()
    
    // MARK: Firebase reference
    var ref:FIRDatabaseReference? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = FIRDatabase.database().reference()
        
        // MARK: Firebase Code
        
        // ref!.child("users").child("slgraff").setValue(["username": "slgraff"])
        
        _ = self.ref!.child("users/slgraff/wordList").observeEventType(FIRDataEventType.Value, withBlock: { (snapshot) in
            if let postDict = snapshot.value as? [String : String] {
                self.objects = Array<String>(postDict.values)
                print(self.objects)
                // Reload the tableView after making above changes
                self.tableView.reloadData()
            }
            

            
            // ...
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        // objects.insert(NSDate(), atIndex: 0)
        
// Other code found on SO to create string of random chars
//        let aScalers = "a".unicodeScalars
//        let aCode = aScalers[aScalers.startIndex].value
//        
//        let letters: [Character] = (0..<26).map {
//            i in Character(UnicodeScalar(aCode + i))
//        }
        
        
        // MARK: Make a unique string
        let rangeOfInts = [Int](65...91)
        let rangeOfChars:Array<Character> = rangeOfInts.map { value in
            return Character(UnicodeScalar(value))
        }
        
        var uniqueString = ""
        for _ in 1...6 {
            let random = arc4random_uniform(UInt32(rangeOfChars.count))
            uniqueString.append(rangeOfChars[Int(random)])
        }
        
        objects.insert(uniqueString, atIndex: 0)
        
    
        // MARK: Store data into the Firebase database
        let newUniqueWordLocation = self.ref?.child("users/slgraff/wordList").childByAutoId()
        newUniqueWordLocation?.setValue(uniqueString)
        
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
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
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}

