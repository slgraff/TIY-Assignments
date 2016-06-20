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
        if (client?.name != nil) {
            return "\(client!.name!) Dog Walk on \(walkDate!)"
        } else {
            return "Dog Walk on \(walkDate!)"
        }
    }
    
}
