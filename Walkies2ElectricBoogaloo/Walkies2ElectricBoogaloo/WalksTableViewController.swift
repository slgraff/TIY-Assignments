//
//  WalksTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

class WalksTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var walks = [Walks]()
    
    var selectedWalk: Walks?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: (#selector(WalksTableViewController.addWalk(_:))))
        
        
        if let selectedWalk = selectedWalk {
            title = "Walk: \(selectedWalk)"

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
        tableView.reloadData()
    }
    
    
    func reloadData() {
        let fetchRequest = NSFetchRequest(entityName: "Walks")
        
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Walks] {
                walks = results
            }
        } catch {
            fatalError("There was an error fetching the list of devices!")
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return walks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WalkCell", forIndexPath: indexPath)
        
        let walk = walks[indexPath.row]
        
        // cell.textLabel?.text = walk.walkDescription
        cell.detailTextLabel?.text = "(owner name goes here)"
        
        return cell
    }
    
    
    // MARK: - Actions & Segues
    
    
    // TODO: Create WalkDetailViewController (as a UIViewController)
    func addWalk(sender: AnyObject?) {
        performSegueWithIdentifier("walkDetailSegue", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if selectedWalk != nil && identifier == "walkDetailSegue" {
            return false
        }
        
        return true
    }
    
    
    // TODO: Create WalkDetailViewController (as a TableViewController?)
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let dest = segue.destinationViewController as? WalksTableViewController {
//            dest.managedObjectContext = managedObjectContext
//            
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                let walk = walks[selectedIndexPath.row]
//                dest.walk = walk
//            }
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

