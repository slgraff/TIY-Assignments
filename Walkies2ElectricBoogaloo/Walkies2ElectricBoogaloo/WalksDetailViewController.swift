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
    
    var dogPictureURL: String!
    let noDogPhotoPNG = "no_dog_photo.png"
    
    var walk: Walks?
    var walkDogsArray = [AnyObject]()
    
    var managedObjectContext: NSManagedObjectContext!

    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var walkDateLabel: UILabel!
    @IBOutlet weak var walkArrivalETALabel: UILabel!
    @IBOutlet weak var clientAddressLabel: UILabel!
    
    @IBOutlet weak var dogCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dogCollectionView.dataSource = self
        dogCollectionView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let dogDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        // TODO: Once wrapping below in 'if let' now dogs are not being displayed in CollectionViewCells. Apparently occurs if cell is too large to display in collectionView?
        if let walkDogsArray = walk?.dogs?.sortedArrayUsingDescriptors([dogDescriptor]) {
            self.walkDogsArray = walkDogsArray
            self.dogCollectionView.reloadData()

        
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("walkDogCell", forIndexPath: indexPath) as? DogsCollectionViewCell
        
        if let theDog = walkDogsArray[indexPath.row] as? Dogs {
            if theDog.name != nil {
                cell!.dogNameLabel.text = "\(theDog.name!)"
            } else {
                cell!.dogNameLabel.text = ""
            }
            
            if theDog.sex != nil {
                cell!.dogSexLabel.text = "\(theDog.sex!)"
            } else {
                cell!.dogSexLabel.text = ""
            }
            
            let noDogPhotoURL = NSURL(fileURLWithPath: noDogPhotoPNG).absoluteString
            if (theDog.dogPictureURL != nil) {
                if (theDog.dogPictureURL != noDogPhotoURL) {
                    // Get path to users Documents folder on device
                    let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                    let documentsDirectory: NSString = paths.objectAtIndex(0) as! NSString
                    
                    let path:NSString = documentsDirectory.stringByAppendingString(theDog.dogPictureURL!)
                    cell?.dogImage.image = UIImage(contentsOfFile: path as String)
                    
                } else {
                    cell!.dogImage.image = UIImage(named: noDogPhotoPNG)
                }
            } else {
                // If no dog picture exists, set to noDogPhotoPNG
                cell?.dogImage.image = UIImage(named: noDogPhotoPNG)
            }

        }
        
        // Set attirbutes for the cell
        // cell!.backgroundColor = UIColor.whiteColor()
        

        
        
        // TODO: Review these, think about transitioning to setting contraints in storyboard instead
        
//        cell!.frame.size.width = 100
//        cell!.frame.size.height = 100
        
        cell!.dogImage.frame.size.width = 50
        cell!.dogImage.frame.size.height = 50
        
        cell?.dogNameLabel.frame.size.width = 50
        cell?.dogNameLabel.frame.size.height = 20
        
        cell?.dogSexLabel.frame.size.width = 50
        cell?.dogSexLabel.frame.size.height = 20

        
        cell!.dogImage.layer.cornerRadius = 10
        cell!.dogImage.layer.borderWidth = 2
        cell!.dogImage.layer.borderColor = UIColor.redColor().CGColor

        cell!.dogImage.clipsToBounds = true

        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Handle tap event on a dog
        print("You have tapped on cell \(indexPath.item)")
    }

    
    // MARK: Action methods
    @IBAction func mapWalkButtonTapped(sender: AnyObject) {
        if let walkMapViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkMapVC") as? WalkMapViewController {
            
            walkMapViewController.managedObjectContext = managedObjectContext
            walkMapViewController.walk = walk
            navigationController?.pushViewController(walkMapViewController, animated: true)
        }
        
        
        
        // performSegueWithIdentifier("showWalkMapSegue", sender: self)

    }
    
    
    
//    if let dogDetailViewController = storyboard?.instantiateViewControllerWithIdentifier("DogDetail") as? DogDetailViewController {
//        
//        let dog = dogs[indexPath.row]
//        dogDetailViewController.managedObjectContext = managedObjectContext
//        dogDetailViewController.dog = dog
//        navigationController?.pushViewController(dogDetailViewController, animated: true)
//    }
    
    // MARK: Segue methods
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showWalkMapSegue" {
//            if let destination = segue.destinationViewController as? WalkMapViewController {
//                destination.walk = walk // Pass walk object over to WalkMapVC
//                
//            }
//        }
//    }
    
    
    
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
