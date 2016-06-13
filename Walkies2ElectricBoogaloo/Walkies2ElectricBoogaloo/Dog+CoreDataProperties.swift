//
//  Dog+CoreDataProperties.swift
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

extension Dog {

    @NSManaged var age: String?
    @NSManaged var breed: String?
    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var sex: String?
    @NSManaged var size: String?
    @NSManaged var appointment: Appointment?
    @NSManaged var owner: Client?

}
