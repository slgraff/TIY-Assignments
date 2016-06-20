//
//  Dogs.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/15/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation
import CoreData


class Dogs: NSManagedObject {

    var dogDescription: String {
        if (name != nil) {
            return "\(name!), \(sex), \(age) years old"
        } else {
            return "Incomplete dog info"
        }
    }
}
