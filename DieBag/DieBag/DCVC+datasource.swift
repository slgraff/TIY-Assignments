//
//  DCVC+datasource.swift
//  DieBag
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

extension DiceCollectionViewController {
    //MARK: Datasource Stuff
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // In here we need to create a section for each type of die selected
        // Do no show a section if the count of a die type is 0
        
        
        
        return 1 // default return so Xcode won't cry
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return diceHolder.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dieCell", forIndexPath: indexPath)
        
        let keyArray = Array(diceHolder.keys)
        let selectedDie = diceHolder[keyArray[indexPath.row]]
        let label = UILabel(frame: cell.bounds)
        label.text = String(selectedDie!.currentValue)
        label.textAlignment = .Center
        
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.contentView.addSubview(label)
        
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
    
}
