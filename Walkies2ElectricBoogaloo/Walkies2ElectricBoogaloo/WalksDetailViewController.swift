//
//  WalksDetailViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData


class WalksDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "dogCell"
    
    var walk: Walks?
    // var dog: Dogs?
    var managedObjectContext: NSManagedObjectContext!

    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var walkDateLabel: UILabel!
    @IBOutlet weak var walkArrivalETALabel: UILabel!
    @IBOutlet weak var clientAddressLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Populate information about walk
        if let walk = walk {
            if let client = walk.client {
                clientNameLabel.text = "\(client.name!)"
                clientAddressLabel.text = "\(client.address!)"
            } else {
                clientNameLabel.text = "Select client"
            }
            
            walkDateLabel.text = "\(walk.walkDate!)"
            walkArrivalETALabel.text = "\(walk.walkETABegin!) - \(walk.walkETAEnd!)"
        }
        
        // Populate information about dogs for this walk
        // Crashing here when creating a new walk
        if let dog = walk?.dogs {
            // Populate dog info (CollectionView?)
        } else {
            // Prompt to select dog(s) for this walk
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource Protocol
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: Return count of dogs associated with this walk
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Set contents of items in cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dogCell", forIndexPath: indexPath) as? DogsCollectionViewCell
        
        
        // Display dog picture in imageView
        // cell!.dogImage.image =
        cell!.dogName.text = "\(walk?.dogs?.name)"
        cell!.dogSex.text = "\(walk?.dogs?.sex)"
        
        // Set attirbutes for the cell
        cell!.backgroundColor = UIColor.whiteColor()
        cell!.layer.borderColor = UIColor.redColor().CGColor
        cell!.layer.cornerRadius = 10

        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Handle tap event on a dog
        print("You have tapped on cell \(indexPath.item)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
