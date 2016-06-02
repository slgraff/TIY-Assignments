//
//  DiceCollectionViewController.swift
//  DieBag
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

// diceHolder contains a name for the die, and the die itself
// var diceHolderArray = [count:Int, faces:Int, faceValues:Array<Int>, currentValue:Int]
// var diceHolder:Dictionary<String,Die> = Dictionary()


class DiceCollectionViewController: UICollectionViewController {
        
    var oldLayout: UICollectionViewLayout?
    var newLayout: UICollectionViewLayout?
    
    override func viewDidLoad() {
        

        
        let swapButton = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(swapButtonTapped))
        
        // Create own flow layout
        let newFlowLayout = UICollectionViewFlowLayout()
        newFlowLayout.minimumInteritemSpacing = 20
        newFlowLayout.minimumLineSpacing = 20
        
        oldLayout = self.collectionView?.collectionViewLayout
        newLayout = newFlowLayout
        
        self.collectionView?.collectionViewLayout = newFlowLayout
        
        self.navigationItem.rightBarButtonItem = swapButton
    }
    

    
    func swapButtonTapped() {
        if self.collectionView?.collectionViewLayout == oldLayout {
            self.collectionView?.collectionViewLayout = newLayout!
        } else {
            self.collectionView!.collectionViewLayout = oldLayout!
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            print("I'm shaking in my boots!")
            
            rollTheDice()
            
        }
    }
    
    func rollTheDice() {
        for (key, value) in diceHolder {
            for die in diceHolder[key]! {
                die.rollIt()
            }
        }
        self.collectionView?.reloadData()
    }
    
}