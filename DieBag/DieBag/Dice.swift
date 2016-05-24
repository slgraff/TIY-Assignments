//
//  Dice.swift
//  DieBag
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

// Die class
class Die:AnyObject {
    var faces:Int = 0
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

//// d4 for four-sided die
//class d4:Die {
//    override init () {
//        super.init(faces: 4)
//    }
//}
//
//
//// d6 for six-sided die
//class d6: Die {
//    override init () {
//        super.init(faces: 6)
//    }
//}
//
//// d10 for ten-sided die
//class d10: Die {
//    override init () {
//        super.init(faces: 10)
//    }
//}
//
//// d20 for twenty-sided die
//class d20: Die {
//    override init () {
//        super.init(faces: 20)
//    }
//    
//}





