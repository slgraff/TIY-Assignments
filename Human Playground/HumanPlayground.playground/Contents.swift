/*  
 The Iron Yard Raleigh
 Mobile Engineering
 April - June 2016
 
 Human Playground
    
 Create multiple classes for body parts. Each class will have specific functions and variables that will make the body part work.

 **Normal Mode**
 - Create class BodyPart
 - Create 10 subclasses of BodyPart that contain
    - 2 methods (functions) specific to that part
    - 2 properties specific to that part (var or let)
 
 **Hard Mode**
 - Connect the body parts through properties
 - Tell 15 parts to do something from another part
    - Bonus if you can chain 4+ parts through methods
 
*/


import UIKit

class BodyPart {
    // class for body parts
    
    var numOfParts: Int
    
    init(numOfParts: Int) {
        self.numOfParts = numOfParts
    }

}


class Head: BodyPart {
    // sub-class of BodyPart for Head
    
    var hasHair: Bool
    var headShape: String  // values include: Oval, Long, Round, Square, Heart, Diamond
    
    init(hasHair:Bool, headShape:String) {
        self.hasHair = true
        self.headShape = "Oval"
        super.init(numOfParts:numOfParts)
    }
    
    func shakeHead() -> String {
        // function to shake head
        return("Shaking Head")
    }
    
    func nodHead() -> String {
        // functiont to nod head
        return("Nodding Head")

    }
}



class Eyes: BodyPart {
    // sub-class of BodyPart for Eyes
    
    var eyeColor: String
    var eyeShape: String
    
    init(eyeColor:String, eyeShape:String) {
        self.eyeColor = "Blue"
        self.eyeShape = "Almond"
    }
    
    func closeEyes() {
        // function to close eyes
        
    }
    
    func squint() {
        // function to squint
    }
}



class Ears: BodyPart {
    // sub-class of BodyPart for Ears
    
    var earSize: String
    var earShape: String
    
    init(earSize: String, earShape: String) {
        self.earSize = "Medium"
        self.earShape = "Elvin"
    }
    
    func moveEars() {
        // function to move ears
    }
    
    func popEars() -> String {
        // function to 'pop' ears
        return ("Pop!!")
    }
}



class Nose: BodyPart {
    // sub-class of BodyPart for Nose
    
    var noseSize: String
    var noseShape: String
    
    init(noseSize: String, noseShape: String) {
        self.noseSize = "Medium"
        self.noseShape = "Hook"
    }
    
    func wiggleNose() {
        // function to wiggle nose
    }
    
    func sneeze() {
        // function to sneeze
    }
}



class Mouth: BodyPart {
    // sub-class of BodyPart for Mouth
    var mouthSize: String
    var mouthShape: String
    
    init(mouthSize: String, mouthShape: String) {
        self.mouthSize = "Large"
        self.mouthShape = "Round"
    }
    
    func talk() {
        // function to talk
    }
    
    func makeRaspberry() {
        // function to make 'raspberry' sound
    }
}



class Neck: BodyPart {
    // sub-class of BodyPart for Neck
    
    var neckLength: Float
    var neckCircumference: Float
    
    init(neckLength: Float, neckCircumference: Float) {
        self.neckLength = 4.5
        self.neckCircumference = 18
    }
    
    func bendNeck() {
        // function to bend neck
    }
    
    func stretchNeck() {
        // functin to stretch neck
    }
}



class Torso: BodyPart {
    // sub-class of BodyPart for Torso
    
    var torsoCircumference: Float
    var torsoLength: Float
    
    init(torsoCircumference: Float, torsoLength: Float) {
        self.torsoCircumference = 44
        self.torsoLength = 20.5
    }
    
    func puffChest() {
        // function to puff chest
    }
    
    func twistAround() {
        // function to twist around
    }
}



class Arm: BodyPart {
    // sub-class of BodyPart for Arm
    
    var armLength: Float
    var armHair: Bool
    
    init(armLength: Float, armHair:Bool) {
        self.armLength = 36.5
        self.armHair = true
    }
}



class Hand: BodyPart {
    // sub-class of BodyPart for Hand
    
    var handSize: String
    var numberFingers: Int
    
    init(handSize: String, numberFingers: Int) {
        self.handSize = "Large"
        self.numberFingers = 5
    }
    
    func clapHands() {
        // function to clap hands
    }
    
    func makeFist() {
        // function to make a fist
    }
}



class Leg: BodyPart {
    // sub-class of BodyPart for Leg
    
    var numLegs: Int
    var legLength: Float
    
    init(numLegs: Int, legLength: Float) {
        self.numLegs = 2
        self.legLength = 34
    }
}



class Foot: BodyPart {
    // sub-class of BodyPart for Foot
    
    var numFeet: Int
    var footSize: Float
    
    init(numFeet:Int, footSize:Float) {
        self.numFeet = 2
        self.footSize = 11.0
    }
}
