//
//  Dice.swift
//  DiceRoller
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit


protocol ArrayRepresentable {
    associatedtype ArrayType
    
    func toArray() -> [ArrayType]
}

extension Range : ArrayRepresentable {
    func toArray() -> [Element] {
        return [Element](self)
    }
}

// Dice faces, counts
// 5d4 6d6 3d10 5d20

class Die:AnyObject {
    var faces:Int = 20
    var faceValues:Array<Int> { return (1...faces).toArray() }
    var currentValue = 0
    var name: String?
    
    init(){
        name = ""
    }
    
    func rollIt() {
        currentValue = faceValues[Int (arc4random_uniform(UInt32(faces)))]
    }
    
}