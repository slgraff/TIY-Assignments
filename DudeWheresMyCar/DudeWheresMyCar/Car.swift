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
    internal var subtitle:String?
    
    init(title: String,
         subtitle: String) {
        
        self.title = title
        self.subtitle = subtitle
    }
    
    required convenience init?(coder aDecoder:NSCoder) {  // aDecoder is an NSCoder object that has values and keys
        
        guard let title = aDecoder.decodeObjectForKey("title") as? String,
                subtitle = aDecoder.decodeObjectForKey("subtitle") as? String
            else {
                return nil
            }
        
        self.init(title:title, subtitle:subtitle)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(subtitle, forKey: "subtitle")
    }
    
}