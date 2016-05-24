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
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.diceHolder.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dieCell", forIndexPath: indexPath)
        
        let keyArray = Array(self.diceHolder.keys)
        let selectedDie = self.diceHolder[keyArray[indexPath.row]]
        let label = UILabel(frame: cell.bounds)
        label.text = String(selectedDie!.currentValue)
        label.textAlignment = .Center
        
        //        // a map is all of your elements one at a time
        //        // similar to iterating through using a for loop
        //        for subView in cell.contentView.subviews.map { (subView) -> () in
        //            subView.removeFromSuperview()
        //        }
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.contentView.addSubview(label)
        
        cell.backgroundColor = UIColor.blueColor()
        
        return cell
    }
    
    
}
