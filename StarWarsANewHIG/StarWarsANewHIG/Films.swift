//
//  Films.swift
//  StarWarsANewHIG
//
//  Created by Steve Graff on 5/25/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class Film:AnyObject {
    
    var title: String
    var episode: Int

    init(title: String, episode: Int) {
        self.title = title
        self.episode = episode
    }
    
}