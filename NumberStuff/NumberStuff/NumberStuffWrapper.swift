//
//  NumberStuffWrapper.swift
//  NumberStuff
//
//  Created by Steve Graff on 5/11/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import Foundation

let someNumberStuff = NumberStuff()

let staticArray = NumberStuff.thousandInts()

class NumberWrapper: NumberStuff {
    
    func passThroughArray() -> Array<NSNumber> {
        
        return NumberStuff.thousandInts() as! Array<NSNumber>
    }

}

extension NumberStuff {
    func someNewArray() -> Array<AnyObject> {  // Returns an array of any object, but is lazy coding
        
        var tupleArray = [(Int,String)]()
        let numberArray = NumberStuff.thousandInts()
        let stringArray = NumberStuff.randomStrings()
        
        for <#item#> in <#items#> {
            <#code#>
        }
        
        return [ NumberStuff.thousandInts(), NumberStuff.randomStrings()]
    }
    
    class func anotherNewArray() -> Array<Int> {  // returns array of Int
        return [1,2,3,4,5]
    }
}