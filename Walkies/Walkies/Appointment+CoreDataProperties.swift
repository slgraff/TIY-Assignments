//
//  Appointment+CoreDataProperties.swift
//  Walkies
//
//  Created by Steve Graff on 6/11/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Appointment {

    @NSManaged var arrivalTime: NSDate?
    @NSManaged var departureTime: NSDate?
    @NSManaged var notes: String?
    @NSManaged var apptTime: NSDate?
    @NSManaged var client: String?
    @NSManaged var walkMap: NSData?
    @NSManaged var picture: NSData?
    @NSManaged var dogs: String?
    @NSManaged var taskList: String?
    @NSManaged var dlent: NSManagedObject?
    @NSManaged var dog: NSSet?

}
