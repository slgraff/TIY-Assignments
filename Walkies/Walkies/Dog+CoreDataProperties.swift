//
//  Dog+CoreDataProperties.swift
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

extension Dog {

    @NSManaged var age: String?
    @NSManaged var sex: String?
    @NSManaged var size: String?
    @NSManaged var breed: String?
    @NSManaged var name: String?
    @NSManaged var notes: String?
    @NSManaged var owner: NSManagedObject?
    @NSManaged var appointment: NSManagedObject?

}
