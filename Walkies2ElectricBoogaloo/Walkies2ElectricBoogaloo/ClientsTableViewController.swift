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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

