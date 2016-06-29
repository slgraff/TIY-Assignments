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
        
        if let selectedWalk = selectedWalk {
            title = "Walk: \(selectedWalk.walkDate)"
        } else {
            title = "Walks"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: (#selector(WalksTableViewController.addWalk(_:))))
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
        
        
        // Set background color for alternate rows
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColorFromRGB(0xAAFFAF)  // 0xAAFFAF is a lovely pastelle green

        } else {
            cell.backgroundColor = UIColor.whiteColor()
        }
        
        let walk = walks[indexPath.row]
        
        cell.textLabel?.text = walk.walkDescription
        cell.detailTextLabel?.text = walk.notes
        
        return cell
    }
    

    // MARK: - Actions & Segues
    
    
    func addWalk(sender: AnyObject?) {
        performSegueWithIdentifier("showWalkDetailSegue", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if selectedWalk != nil && identifier == "showWalkDetailSegue" {
            return false
        }
        
        return true
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? WalksDetailViewController {
            dest.managedObjectContext = managedObjectContext
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let walk = walks[selectedIndexPath.row]
                dest.walk = walk
            }
        }
    }
    
    
    // MARK: UIColor from RGB method
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    


}

