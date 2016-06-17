//
//  DogsDetailTableViewController.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class DogsDetailTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var chooseDogPictureButton: UIButton!
    @IBOutlet weak var takeDogPictureButton: UIButton!
    
    @IBOutlet weak var dogNameLabel: UILabel!
    @IBOutlet weak var dogOwnerNameLabel: UILabel!
    @IBOutlet weak var dogAgeLabel: UILabel!
    @IBOutlet weak var dogSexLabel: UILabel!
    
    // Declare image picker
    let dogPicPicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dogPicPicker.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
