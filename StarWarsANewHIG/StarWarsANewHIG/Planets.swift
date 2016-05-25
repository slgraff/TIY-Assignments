//
//  Planets.swift
//  StarWarsANewHIG
//
//  Created by Steve Graff on 5/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit


class Planets:AnyObject {
    
    var name: String
    var climate: String
    var population: UInt64
    var surface_water: Int
    
    init(name: String, climate: String, population: UInt64,
         surface_water: Int) {
        
        self.name = name
        self.climate = climate
        self.population = population
        self.surface_water = surface_water
        
    }
    
}
