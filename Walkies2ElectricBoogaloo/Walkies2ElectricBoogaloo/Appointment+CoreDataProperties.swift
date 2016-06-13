//
//  Appointment+CoreDataProperties.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Appointment {

    @NSManaged var apptTime: NSDate?
    @NSManaged var arrivalTime: NSDate?
    @NSManaged var client: String?
    @NSManaged var departureTime: NSDate?
    @NSManaged var dogs: String?
    @NSManaged var notes: String?
    @NSManaged var picture: NSData?
    @NSManaged var taskList: String?
    @NSManaged var walkMap: NSData?
    @NSManaged var dlent: Client?
    @NSManaged var dog: NSSet?

}
