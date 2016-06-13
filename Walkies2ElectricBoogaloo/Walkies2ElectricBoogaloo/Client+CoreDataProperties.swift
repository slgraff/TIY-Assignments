//
//  Client+CoreDataProperties.swift
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

extension Client {

    @NSManaged var address: String?
    @NSManaged var dogs: String?
    @NSManaged var email: String?
    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var securityInfo: String?
    @NSManaged var appointment: Appointment?
    @NSManaged var dog: Dog?

}
