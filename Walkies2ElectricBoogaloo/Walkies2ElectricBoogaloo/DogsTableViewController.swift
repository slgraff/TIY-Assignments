//
//  DogsTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData


class DogsTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var dogs = [Dogs]()
    
    // weak var pickerDelegate: DogPickerDelegate?
    var selectedDog: Dogs?
    var selectedClient: Clients?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedDog = selectedDog {
            title = "Dog: \(selectedDog.name)"
        } else {
            title = "Dogs"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: (#selector(DogsTableViewController.addDog(_:))))
        }
        
        reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func reloadData() {
        
        if let selectedClient = selectedClient {
            if let clientDogs = selectedClient.dogs!.allObjects as? [Dogs] {
                dogs = clientDogs
            }
        } else {
            let fetchRequest = NSFetchRequest(entityName: "Dogs")
                
            do {
                if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Dogs] {
                    dogs = results
                    // tableView.reloadData()
                }
            } catch {
                fatalError("Error fetching list of dogs!")
            }
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
            if let dogDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("DogDetail") as? DogDetailViewController {
                
                let dog = dogs[indexPath.row]
                dogDetailViewController.managedObjectContext = managedObjectContext
                dogDetailViewController.dog = dog
                navigationController?.pushViewController(dogDetailViewController, animated: true)
            }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    

    // MARK: Actions & Segues

    func addDog(sender: AnyObject?) {
        performSegueWithIdentifier("dogDetailSegue", sender: self)
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
