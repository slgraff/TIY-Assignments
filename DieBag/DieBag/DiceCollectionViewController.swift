//
//  DiceCollectionViewController.swift
//  DiceRoller
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class DiceCollectionViewController: UICollectionViewController {
    
    // Declare our dictionary to hold dice rolls
    var diceHolder:Dictionary<String,Die> = Dictionary()
    
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
    
    func plusButtonTapped() {
        let newDie = Die()
        newDie.name = "Jeff\(self.diceHolder.count)"
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