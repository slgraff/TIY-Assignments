//
//  DiceChoiceViewController.swift
//  DieBag
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

// Declare a dictionary with string as key, array as value
// Key is for die type (d4, d6, d10, d20), Value is array of Die objects
var diceHolder:[String:Array<Die>] = Dictionary()


class DiceChoiceViewController: UIViewController {
    
    // Dice label outlets
    @IBOutlet weak var dieD4Label: UILabel!
    @IBOutlet weak var dieD6Label: UILabel!
    @IBOutlet weak var dieD10Label: UILabel!
    @IBOutlet weak var dieD20Label: UILabel!

    // Dice slider outlets
    @IBOutlet weak var dieD4Slider: UISlider!
    @IBOutlet weak var dieD6Slider: UISlider!
    @IBOutlet weak var dieD10Slider: UISlider!
    @IBOutlet weak var dieD20Slider: UISlider!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: Overridden methods to support motion detection
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("I'm shaking in my boots!")
            
            getDiceChoices()
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    func prepareForSegue(segue: diceCollectionSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    
    
    // MARK: Get Dice Choices
    func getDiceChoices() {
        
        // Clear out diceHolder of current values
        diceHolder.removeAll(keepCapacity: true)
        
        // Declare dictionary to hold die type, quantity
        var dieCountDict = ["d4":0, "d6":0, "d10":0,"d20":0]
        
        // Set name of die, quantity selected, and number of faces on the die
        dieCountDict["d4"] = Int(dieD4Slider.value)
        dieCountDict["d6"] = Int(dieD6Slider.value)
        dieCountDict["d10"] = Int(dieD10Slider.value)
        dieCountDict["d20"] = Int(dieD20Slider.value)
        
        // Loop through dieCountDict, creating dice, rolling them
        // and adding to the diceHolder
        for (dieType, dieCount) in dieCountDict {
            
            // Repeat for the value for the key
            for i in 1...dieCount {
                
                // Create a new die
                let newDie = Die()
                
                // Set appropriate number of faces
                switch dieType {
                case "d4":
                    newDie.faces = 4
                    newDie.name = "\(dieType) \(dieCount)"
                case "d6":
                    newDie.faces = 6
                    newDie.name = "\(dieType) \(dieCount)"
                case "d10":
                    newDie.faces = 10
                    newDie.name = "\(dieType) \(dieCount)"
                case "d20":
                    newDie.faces = 20
                    newDie.name = "\(dieType) \(dieCount)"
                default:
                    newDie.faces = 0
                }
                newDie.rollIt()
                
                // add the die to the dice holder
                if let diceArray = diceHolder[dieType] {
                    diceHolder[dieType]!.append(newDie)
                } else {
                    // var diceArray = [newDie]
                    diceHolder[dieType] = [newDie]
                }
                    
                
            }
        }
    }
    
    @IBAction func dieSliderValueChanged(sender: AnyObject) {
        
        // When any slider is changed, update values for all slider labels
        dieD4Label.text = String(Int(dieD4Slider.value))
        dieD6Label.text = String(Int(dieD6Slider.value))
        dieD10Label.text = String(Int(dieD10Slider.value))
        dieD20Label.text = String(Int(dieD20Slider.value))
    }
    
    
    @IBAction func shakeDiceButton(sender: UIButton) {

        getDiceChoices()
    }
    


}
