//
//  DiceCollectionViewController.swift
//  DieBag
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

// diceHolder contains a name for the die, and the die itself
var diceHolder:Dictionary<String,Die> = Dictionary()


class DiceCollectionViewController: UICollectionViewController {
        
    var oldLayout: UICollectionViewLayout?
    var newLayout: UICollectionViewLayout?
    
    override func viewDidLoad() {
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(DiceCollectionViewController.plusButtonTapped))
        
        let swapButton = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(swapButtonTapped))
        
        // Create own flow layout
        let newFlowLayout = UICollectionViewFlowLayout()
        newFlowLayout.minimumInteritemSpacing = 20
        newFlowLayout.minimumLineSpacing = 20
        
        oldLayout = self.collectionView?.collectionViewLayout
        newLayout = newFlowLayout
        
        self.collectionView?.collectionViewLayout = newFlowLayout
        
        self.navigationItem.leftBarButtonItem = plusButton
        self.navigationItem.rightBarButtonItem = swapButton
    }
    
    
    // Do we even need this in our collection view? It will display the rolled dice only
    // Dice are not created here
    // Should instead have button to go back to DiceChoiceViewController
    func plusButtonTapped() {
        
        let newDie = Die()
        // newDie.name = "Die\(self.diceHolder.count)"
        newDie.rollIt()
        diceHolder[newDie.name!] = newDie
        self.collectionView?.reloadData()
    }
    
    func swapButtonTapped() {
        if self.collectionView?.collectionViewLayout == oldLayout {
            self.collectionView?.collectionViewLayout = newLayout!
        } else {
            self.collectionView!.collectionViewLayout = oldLayout!
        }
    }
    
}