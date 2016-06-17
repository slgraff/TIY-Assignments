//
//  Walks.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation
import CoreData


class Walks: NSManagedObject {

    var walkDescription: String {
        
        // TODO: Add client name to this
        // return "\(walk.client.name)'s Dog Walk on \(walkDate!)"
        return "Dog Walk on \(walkDate!)"

    }
}
