//
//  ClientsTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

protocol ClientPickerDelegate: class {
    func didSelectClient(client: Clients)
}

class ClientsTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var clients = [Clients]()
    
    weak var pickerDelegate: ClientPickerDelegate?
    var selectedClient: Clients?


    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Clients"
        
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
        if let pickerDelegate = pickerDelegate {
            let client = clients[indexPath.row]
            selectedClient = client
            pickerDelegate.didSelectClient(client)
            
            tableView.reloadData()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    // MARK: Error Handling

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

