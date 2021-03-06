//
//  Walks+CoreDataProperties.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/23/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Walks {

    @NSManaged var arrivalTime: NSDate?
    @NSManaged var departureTime: NSDate?
    @NSManaged var notes: String?
    @NSManaged var dogPictureURL: String?
    @NSManaged var taskList: String?
    @NSManaged var walkDate: String?
    @NSManaged var walkETABegin: String?
    @NSManaged var walkETAEnd: String?
    @NSManaged var walkMapSnapshotURL: String?
    @NSManaged var client: Clients?
    @NSManaged var dogs: NSSet?

}
