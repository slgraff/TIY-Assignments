// 
// The Iron Yard Raleigh
// Mobile Engineering
//
// Code Kata, Thurs May 12
// 
// Write a function that will reverse a string in Swift
// 

import UIKit


func reverseString(string:String) -> String {
    
    return String(string.characters.reverse())
}

let stringToReverse = "backwards"
let backwards = reverseString(stringToReverse)
print("The string '\(stringToReverse)' in reverse is '\(backwards)'")
