//
//  ClientsTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData


class ClientsTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var clients = [Clients]()
    
    var selectedClient: Clients?
    var selectedDog: Dogs?


    override func viewDidLoad() {
        super.viewDidLoad()

        if let selectedClient = selectedClient {
            title = "Client: \(selectedClient.name)"
        } else {
            title = "Clients"
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: (#selector(ClientsTableViewController.addClient(_:))))
        }
                
        reloadData()
    }
    
    func reloadData() {
        let fetchRequest = NSFetchRequest(entityName: "Clients")
        
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Clients] {
                clients = results
                tableView.reloadData()
            }
        } catch {
            fatalError("Error fetching list of clients!")
        }
        
    }
    
    
    // MARK: Table View data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClientCell", forIndexPath: indexPath)
        
        let client = clients[indexPath.row]
        cell.textLabel?.text = client.name
        
        if let selectedClient = selectedClient where selectedClient == client {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            let client = clients[indexPath.row]
            selectedClient = client
        
//            tableView.reloadData()
        
            // TODO: This isn't populating list of dogs associated with client
            if let clientDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("ClientDetail") as? ClientDetailViewController {
                let client = clients[indexPath.row]
                
                clientDetailViewController.managedObjectContext = managedObjectContext
                // clientDetailViewController.selectedClient = client
                navigationController?.pushViewController(clientDetailViewController, animated: true)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    // MARK: Actions & Segues
    
    // TODO: Do I need to implement prepareForSegue ??
    
    func addClient(sender: AnyObject?) {
        performSegueWithIdentifier("showClientDetailSegue", sender: self)
    }
    
    
    
    // MARK: Error Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

