//
//  Starships.swift
//  StarWarsANewHIG
//
//  Created by Steve Graff on 5/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class Starships:AnyObject {
    
    var name: String
    var model: String
    var manufacturer: String
    var length: Float
    var crew: Int
    var passengers: Int
    var cargo_capacity: Double
    
    init(name: String, model: String, manufacturer: String,
         length: Float, crew: Int, passengers: Int, cargo_capacity: Double) {
        
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.length = length
        self.crew = crew
        self.passengers = passengers
        self.cargo_capacity = cargo_capacity
    }
}
