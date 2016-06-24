
//
//  ClientDetailViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

class ClientDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // @IBOutlet weak var clientDogCollectionView: UICollectionView!
    
    let reuseIdentifier = "ClientDogCell"
    
    var dogPictureURL: String!
    let noDogPhotoPNG = "no_dog_photo.png"
    
    var client: Clients?
    var clientDogsArray = [AnyObject]()
    
    var managedObjectContext: NSManagedObjectContext!

    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var clientAddressLabel: UILabel!
    @IBOutlet weak var clientPhoneLabel: UILabel!
    @IBOutlet weak var clientEmailLabel: UILabel!
    
    @IBOutlet weak var clientSecurityInfoTextView: UITextView!
    
    @IBOutlet weak var clientNotesTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
// TODO: Do I need to do this?
//        self.ClientDetailViewController.delegate = self
//        self.ClientDetailViewController.datasource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get clients dogs
        let clientDescriptor = NSSortDescriptor(key: "name", ascending: true)
        clientDogsArray = client!.dogs!.sortedArrayUsingDescriptors([clientDescriptor])
        
        // Populate info about client
        if let client = client {
            
            if (client.name != nil) {
                clientNameLabel.text = "\(client.name!)"
            } else {
                clientNameLabel.text = ""
            }
            
            if (client.address != nil) {
                clientAddressLabel.text = "\(client.address!)"
            } else {
                clientAddressLabel.text = ""
            }
            
            if (client.phone != nil) {
                clientPhoneLabel.text = "\(client.phone!)"
            } else {
                clientPhoneLabel.text = ""
            }
            
            if (client.email != nil) {
                clientEmailLabel.text = "\(client.email!)"
            } else {
                clientEmailLabel.text = ""
            }
            
            if (client.securityInfo != nil) {
                clientSecurityInfoTextView.text = "\(client.securityInfo!)"
            } else {
                clientSecurityInfoTextView.text = ""
            }
            
            if (client.notes != nil) {
                clientNotesTextView.text = "\(client.notes!)"
            } else {
                clientNotesTextView.text = ""
            }
        }
        

    }
    
    
    // MARK: UICollectionViewDataSource Protocol
    
    func collectionView(collectionView:UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return count of dogs associated with this walk
        return clientDogsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // Set contents of items in cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClientDogCell", forIndexPath: indexPath) as? DogsCollectionViewCell
        
//        // Configure the cell
//        cell!.contentView.backgroundColor = UIColor.grayColor()
//        
//        let clientDogNameLabel: UILabel = UILabel()
//        clientDogNameLabel.frame = CGRect(x: 10, y: 10, width: (cell!.contentView.frame.width - 20), height: ((cell?.contentView.frame.height)! - 30) / 4)
//        clientDogNameLabel.backgroundColor = UIColor.whiteColor()
//        clientDogNameLabel.textColor = UIColor.blackColor()
        
        
        if let theDog = clientDogsArray[indexPath.row] as? Dogs {
            
            if theDog.name != nil {
                cell!.dogNameLabel.text = "\(theDog.name!)"
            } else {
                cell!.dogNameLabel.text = ""
            }
            
            if theDog.sex != nil {
                cell!.dogSexLabel.text = "\(theDog.sex)"
            } else {
                cell!.dogSexLabel.text = ""
            }
            
            
            // Display image of the dog
            // TODO: Fix this, no image being displayed
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
        cell!.backgroundColor = UIColor.whiteColor()
        cell!.layer.borderColor = UIColor.redColor().CGColor
        cell!.layer.borderWidth = 2
        // cell!.layer.cornerRadius = 90
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // Handle tap event on a dog
        print("You have tapped on cell \(indexPath.item)")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
