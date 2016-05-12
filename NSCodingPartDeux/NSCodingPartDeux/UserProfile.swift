//
//  UserProfile.swift
//  NSCodingPartDeux
//
//  Created by Steve Graff on 5/12/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation

// Extension to the String class, returns a reversed version
extension String {
    static func stringWithDoubleFormat(format: String, secondFormat: String) -> Int {
        return 2
    }
    
    func reverse() -> String {
        return String(self.characters.reverse())
    }
    
}


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
    
    required convenience init?(coder aDecoder: NSCoder) {
        // guard checks if anything goes wrong
        guard let name = aDecoder.decodeObjectForKey("name") as? String,
            let userID = aDecoder.decodeObjectForKey("pass") as? String,
            let password = aDecoder.decodeObjectForKey("id") as? String,
            let profilePic = aDecoder.decodeObjectForKey("profileURL") as? NSURL
        else{return nil}
        
        self.init(name:name, userID: userID, password: password.reverse(), profile: profilePic) // using String extension to reverse string here
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        let someInt = String.stringWithDoubleFormat("", secondFormat: "")
        // print someInt
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(userID, forKey: "id")
        aCoder.encodeObject(password?.reverse(), forKey:"pass")  // using String extension to reverse string here
        aCoder.encodeObject(profilePictureURL, forKey: "profileURL")
    }
}