//
//  DogsTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

protocol DogPickerDelegate: class {
    func didSelectDog(dog: Dogs)
}

class DogsTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var dogs = [Dogs]()
    
    weak var pickerDelegate: DogPickerDelegate?
    var selectedDog: Dogs?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Dogs"
        
        reloadData()
    }
    
    func reloadData() {
        let fetchRequest = NSFetchRequest(entityName: "Dogs")
        
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Dogs] {
                dogs = results
                tableView.reloadData()
            }
        } catch {
            fatalError("Error fetching list of dogs!")
        }
    }
    
    
    // MARK: Table View data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DogCell", forIndexPath: indexPath)
        
        let dog = dogs[indexPath.row]
        cell.textLabel?.text = dog.name
        
        if let selectedDog = selectedDog where selectedDog == dog {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let pickerDelegate = pickerDelegate {
            let dog = dogs[indexPath.row]
            selectedDog = dog
            pickerDelegate.didSelectDog(dog)
            
            tableView.reloadData()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: Memory Error Handling

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
