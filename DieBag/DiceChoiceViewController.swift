//
//  DiceChoiceViewController.swift
//  DieBag
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

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
        
        var dieChoiceDict: [String:Int] = [:]
        
        dieChoiceDict.updateValue(Int(dieD4Slider.value), forKey: "d4")
        dieChoiceDict.updateValue(Int(dieD6Slider.value), forKey: "d6")
        dieChoiceDict.updateValue(Int(dieD10Slider.value), forKey: "d10")
        dieChoiceDict.updateValue(Int(dieD20Slider.value), forKey: "d20")
        
        
        // Create appropriate number of dice of each type
        // Loop through dieChoiceDict
        
        for (dieTypes, dieNums) in dieChoiceDict {
            
//            print("Key: \(dieTypes), Value: \(dieNums)")
            
            for dieNum in 1...dieNums {
//                print("\(dieTypes): \(dieNum) of \(dieNums)")
                
                // Create a new die
                let newDie = Die()

                // Set appropriate number of faces
                switch dieTypes {
                case "d4":
                    newDie.faces = 4
                    newDie.name = "\(dieTypes) \(dieNum)"
                case "d6":
                    newDie.faces = 6
                    newDie.name = "\(dieTypes) \(dieNum)"
                case "d10":
                    newDie.faces = 10
                    newDie.name = "\(dieTypes) \(dieNum)"
                case "d20":
                    newDie.faces = 20
                    newDie.name = "\(dieTypes) \(dieNum)"
                default:
                    newDie.faces = 0
                }
                newDie.rollIt()
                
                // add the die to the dice holder
                diceHolder[newDie.name!] = newDie
                
                print("Created die \(dieTypes) \(dieNum)")
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
        let alert = UIAlertController(title: "Shaking Dice",
                                      message: "I'm shaking your dice",
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        getDiceChoices()
    }
    


}
