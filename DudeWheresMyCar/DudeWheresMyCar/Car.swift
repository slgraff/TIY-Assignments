//
//  Car.swift
//  DudeWheresMyCar
//
//  Created by Steve Graff on 5/19/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation


class Car: NSObject, NSCoding {
    
    // MARK: Properties
    internal var title: String?
    internal var lat: Double?
    internal var lon: Double?
    // internal var subtitle:String?
    
    // MARK: Archiving paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("car")
    
    // MARK: Initializaton
    init?(title: String,
         lat: Double, lon: Double) {
        
        self.title = title
        self.lat = lat
        self.lon = lon
        
        super.init()
        // self.subtitle = subtitle
        
        if title.isEmpty {
            return nil
        }
    }
    
    required convenience init?(coder aDecoder:NSCoder) {  // aDecoder is an NSCoder object that has values and keys
        
        guard let title = aDecoder.decodeObjectForKey("title") as? String,
                lat = aDecoder.decodeObjectForKey("lat") as? Double,
                lon = aDecoder.decodeObjectForKey("long") as? Double
                // subtitle = aDecoder.decodeObjectForKey("subtitle") as? String
            else {
                return nil
            }
        
        self.init(title:title, lat:lat, lon:lon)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeDouble(lat!, forKey: "lat")
        aCoder.encodeDouble(lon!, forKey: "lon")
        aCoder.encodeObject(title, forKey: "title")
        // aCoder.encodeObject(subtitle, forKey: "subtitle")
        
    }
    
}