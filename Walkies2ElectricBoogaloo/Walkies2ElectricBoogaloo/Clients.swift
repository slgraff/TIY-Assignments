//
//  Clients.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation
import CoreData


class Clients: NSManagedObject {

    var clientDescription: String {
        if (name != nil) {
            return "\(name!), \(address)"
        } else {
            return "Incomplete client info"
        }
    }
}
