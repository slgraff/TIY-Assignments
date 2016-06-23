//
//  DogDetailViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/20/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData


class DogDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var dog: Dogs?
    var managedObjectContext: NSManagedObjectContext!
    
    let dogPicPicker = UIImagePickerController()

    var dogPictureURL: String!
    let noDogPhotoPNG = "no_dog_photo.png"
    
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var chooseDogPictureButton: UIButton!
    @IBOutlet weak var takeDogPictureButton: UIButton!
    
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogOwnerNameLabel: UILabel!
    @IBOutlet weak var dogAgeLabel: UILabel!
    @IBOutlet weak var dogSexLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        dogPicPicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Running DogDetailVC -> viewWillAppear")

        
        dogNameLabel.text = dog!.name!
        dogAgeLabel.text = dog!.age!
        dogSexLabel.text = dog!.sex!
        
        let noDogPhotoURL = NSURL(fileURLWithPath: noDogPhotoPNG).absoluteString
        if (dog!.dogPictureURL != nil) {
            if (dog!.dogPictureURL != noDogPhotoURL) {
                // Get path to users Documents folder on device
                let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
                let documentsDirectory: NSString = paths.objectAtIndex(0) as! NSString
                
                let path:NSString = documentsDirectory.stringByAppendingString(dog!.dogPictureURL!)
                self.dogImageView.image = UIImage(contentsOfFile: path as String)
                
            } else {
                self.dogImageView.image = UIImage(named: noDogPhotoPNG)
            }
        } else {
            // If no dog picture exists, set to noDogPhotoPNG
            self.dogImageView.image = UIImage(named: noDogPhotoPNG)
        }
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        // Tried moving code from viewWillAppear into this, dogImage is still not being retrieved or drawin
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
    
    
    // MARK: Button Actions
    
    @IBAction func chooseDogPictureButtonPressed(sender: AnyObject) {
        dogPicPicker.sourceType = .PhotoLibrary
        dogPicPicker.allowsEditing = false
        presentViewController(dogPicPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func takeDogPictureButtonPressed(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            dogPicPicker.sourceType = .Camera
            dogPicPicker.allowsEditing = false
            presentViewController(dogPicPicker, animated: true, completion: nil)
        } else {
            // Disable the take picture button if no rear camera
            // Useful for running in simulator
            
            let alert = UIAlertController(title: "Error", message: "There is no camera available!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default,
                handler: {(alertAction) in
                    alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion:nil)
            
            self.takeDogPictureButton.enabled = false
        
        }
    }
    
    
    // MARK: UIImagePicker Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // Scale image size for display on this device
            let scaledImage: UIImage = scaledImageFromImage(image,
                                size: (UIScreen.mainScreen().bounds.size))
            
            
            // Get path to users Documents folder on device
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory: NSString = paths.objectAtIndex(0) as! NSString
            
            // Create a date string to use as unique file name for image
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd-HH-mm-ss"
            let now: NSDate = NSDate(timeIntervalSinceNow: 0)
            let theDate: NSString = dateFormat.stringFromDate(now)
            
            // Save data to documents directory
            self.dogPictureURL = NSString(format: "/%@.png", theDate) as String
            let fullPath:NSString = documentsDirectory.stringByAppendingString(self.dogPictureURL)
            let pngData: NSData = UIImagePNGRepresentation(scaledImage)!
            pngData.writeToFile(fullPath as String, atomically: true)

            
            // Save picture URL to core data
            dog?.dogPictureURL = self.dogPictureURL
            
            // TODO: Unclear if dogPicturURL is being written to store or not
            saveContext()
            

            self.dogImageView.image = scaledImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Close the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: scaleImageFromImage method
    
    func scaledImageFromImage (image: UIImage, size: CGSize) -> UIImage {
        
        let scale: CGFloat = max(size.width/image.size.width, size.height/image.size.height)
        let width: CGFloat = image.size.width * scale
        let height: CGFloat = image.size.height * scale
        let imageRect: CGRect = CGRectMake((size.width - width)/2.0, (size.height - height)/2.0, width, height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.drawInRect(imageRect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
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
    
}
