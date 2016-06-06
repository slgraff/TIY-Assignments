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
        
        // Return count of keys in dieCountDict
        return diceHolder.keys.count
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return diceHolder["d4"]!.count
        case 1:
            return diceHolder["d6"]!.count
        case 2:
            return diceHolder["d10"]!.count
        case 3:
            return diceHolder["d20"]!.count
        default:
            return 0
        }

    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dieCell", forIndexPath: indexPath)
        
        let keyArray = ["d4", "d6", "d10", "d20"]
        //let keyArray = Array(diceHolder.keys)
        let selectedDie = diceHolder[keyArray[indexPath.section]]![indexPath.row]
        let label = UILabel(frame: cell.bounds)
        label.text = String(selectedDie.currentValue)
        label.textAlignment = .Center
        
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        cell.contentView.addSubview(label)
        
        cell.backgroundColor = UIColor.yellowColor()
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
                        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
        
            case UICollectionElementKindSectionHeader:
            
                let headerView =
                    collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier: "DiceCollectionHeaderView",
                            forIndexPath: indexPath) as! DiceCollectionHeaderView
                
                let keyArray = ["d4", "d6", "d10", "d20"]
                headerView.diceSectionLabel.text = keyArray[indexPath.section]
                return headerView
            default:
                assert(false, "Unexpected element kind")
        }
        fatalError("Unexpected element kind")

    }

    
    
}
