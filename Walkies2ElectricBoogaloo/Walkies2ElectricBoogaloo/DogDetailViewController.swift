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
        
        dogNameLabel.text = dog!.name!
        dogAgeLabel.text = dog!.age!
        dogSexLabel.text = dog!.sex!
        
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
    
    // TODO: Why are these crashing the app?
    @IBAction func chooseDogPictureButtonPressed(sender: AnyObject) {
        dogPicPicker.sourceType = .PhotoLibrary
        dogPicPicker.allowsEditing = false
        presentViewController(dogPicPicker, animated: true, completion: nil)
        
    }
    
    @IBAction func takeDogPictureButtonPressed(sender: AnyObject) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            dogPicPicker.sourceType = .Camera
            dogPicPicker.allowsEditing = true
            presentViewController(dogPicPicker, animated: true, completion: nil)
        } else {
            // Disable the take picture button if no rear camera
            // Useful for running in simulator
            self.takeDogPictureButton.enabled = false
        }
    }
    
    
    // MARK: UIImagePicker Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let edited = info[UIImagePickerControllerEditedImage] as? UIImage {
            dogImageView.image = edited
        } else if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
            dogImageView.image = photo
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Close the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
