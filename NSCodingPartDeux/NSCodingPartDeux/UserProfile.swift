//
//  UserProfile.swift
//  NSCodingPartDeux
//
//  Created by Steve Graff on 5/12/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation


class UserProfile: NSObject, NSCoding {
    
    var name: String?
    var userID: String?
    var password: String?
    var profilePictureURL: NSURL?

    init(name: String,
         userID: String,
         password: String,
         profile: NSURL) {
        
        self.name = name
        self.userID = userID
        self.password = password
        self.profilePictureURL = profile
        
    }
}