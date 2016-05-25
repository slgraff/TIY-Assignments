//
//  People.swift
//  StarWarsANewHIG
//
//  Created by Steve Graff on 5/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit


class Person:AnyObject {
    
    let dateFormatter = NSDateFormatter()
    
    var createdDate:NSDate
    var name: String
    var height: Float
    var mass: Float
    var gender: String
    var url: String
    
    init(createdDate: NSDate, name: String, height: Float,
         mass: Float, gender: String, url: String) {
        
        self.createdDate = createdDate
        self.name = name
        self.height = height
        self.mass = mass
        self.gender = gender
        self.url = url
        
        // TODO: Format the returned created date somewhere
        
        /* 
        Somewhere I need to format the date received
        Do I do that here in the Person class?
        Or is it done when processing the JSON data?
        Ex date received: 2014-12-09T13:50:51.644000Z


        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = .ShortStyle

        createdDate = dateFormatter.stringFromDate(someDate)
        */
 
    }
}
