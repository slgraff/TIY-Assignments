//
//  Client+CoreDataProperties.swift
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

extension Client {

    @NSManaged var name: String?
    @NSManaged var address: String?
    @NSManaged var phone: String?
    @NSManaged var email: String?
    @NSManaged var securityInfo: String?
    @NSManaged var dogs: String?
    @NSManaged var dog: Dog?
    @NSManaged var appointment: Appointment?

}
