//
//  DCVC+delegate.swift
//  DieBag
//
//  Created by Steve Graff on 5/24/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

extension DiceCollectionViewController {
    //MARK: Delegate Stuff
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let keyArray = Array(self.diceHolder.keys)
        let selectedDie = self.diceHolder[keyArray[indexPath.row]]
        selectedDie?.rollIt()
    }
    
    
}