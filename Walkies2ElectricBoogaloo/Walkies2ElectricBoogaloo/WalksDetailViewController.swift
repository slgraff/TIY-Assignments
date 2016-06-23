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
    var walkDogsArray: Array<AnyObject> = []
    
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
        
        let dogDescriptor = NSSortDescriptor(key: "name", ascending: true)
        walkDogsArray = walk!.dogs!.sortedArrayUsingDescriptors([dogDescriptor])
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UICollectionViewDataSource Protocol
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return count of dogs associated with this walk
        return walkDogsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Set contents of items in cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("dogCell", forIndexPath: indexPath) as? DogsCollectionViewCell
        
        // TODO: Display dog picture in imageView
        // cell!.dogImage.image =
        
        if let theDog = walkDogsArray[indexPath.row] as? Dogs {
            cell!.dogNameLabel.text = "\(theDog.name!)"
            cell!.dogSexLabel.text = "\(theDog.sex!)"

        } else {
            cell!.dogNameLabel.text = "No name"
            cell!.dogSexLabel.text = "Unknown"

        }

        
        // Set attirbutes for the cell
        cell!.backgroundColor = UIColor.whiteColor()
        cell!.layer.borderColor = UIColor.redColor().CGColor
        cell!.layer.borderWidth = 2
        cell!.layer.cornerRadius = 90

        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Handle tap event on a dog
        print("You have tapped on cell \(indexPath.item)")
    }

    
    // MARK: Action methods
    @IBAction func mapWalkButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("showWalkMapSegue", sender: self)

    }
    
    // MARK: Segue methods
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showWalkMapSegue" {
            if let destination = segue.destinationViewController as? WalkMapViewController {
                destination.walk = walk // Pass walk object over to WalkMapVC
            }
        }
    }
    
    
    
    // MARK: - Core Data Save support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
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
