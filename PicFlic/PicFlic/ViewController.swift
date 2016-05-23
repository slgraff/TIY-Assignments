//
//  ViewController.swift
//  SnapShot
//
//  Created by Steve Graff on 5/17/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var takePictureButton: UIButton!
    @IBOutlet var choosePictureButton: UIButton!
    
    private var originalBounds = CGRect.zero
    private var originalCenter = CGPoint.zero
    
    private var animator: UIDynamicAnimator!
    private var attachmentBehavior: UIAttachmentBehavior!
    private var pushBehavior: UIPushBehavior!
    private var itemBehavior: UIDynamicItemBehavior!
    
    
    // Declared up here as image picker is used in multiple actions
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        originalBounds = imageView.bounds
        originalCenter = imageView.center
    }

    
    // MARK: Button Actions
    @IBAction func takeButtonTapped() {
    
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.sourceType = .Camera  // .Camera is an enum, type inference allows this
            picker.allowsEditing = true
            presentViewController(picker, animated: true, completion: nil)
        } else {
            // disable take picture button
            self.takePictureButton.enabled = false
        }
    }
    
    
    @IBAction func chooseButtonPressed() {
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = false
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    // MARK: Delegates
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Wrap in if let to make sure we can 'do the thing'
        // See also guard statement
        if let edited = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = edited
        } else if let photo = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = photo
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // close the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    // MARK: Dynamic Behaviors
    
    func resetPicture() {
        animator.removeAllBehaviors()
        
        UIView.animateWithDuration(0.5, animations: {
            self.imageView.center = self.originalCenter
            self.imageView.bounds = self.originalBounds
            self.imageView.transform = CGAffineTransformIdentity
        })
    }
    
    @IBAction func handleAttachmentGesture(gesture: UIPanGestureRecognizer) {
        let location = gesture.locationInView(self.view)
        let boxLocation = gesture.locationInView(self.imageView)
        
        switch gesture.state {
        case .Began:
            animator.removeAllBehaviors()
            let centerOffset = UIOffset(horizontal: boxLocation.x - imageView.bounds.midX, vertical: boxLocation.y - imageView.bounds.midY)
            attachmentBehavior = UIAttachmentBehavior(item: self.imageView, offsetFromCenter: centerOffset, attachedToAnchor: location)
            animator.addBehavior(attachmentBehavior)
        
        case .Ended:
            animator.removeAllBehaviors()
            let velocity = gesture.velocityInView(self.view)
            let magnitude = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
            
            if magnitude > 1000 {
                let pushBehavior = UIPushBehavior(items: [imageView], mode: .Instantaneous)
                pushBehavior.pushDirection = CGVector(dx: velocity.x, dy: velocity.y)
                pushBehavior.magnitude = magnitude / 50
                
                self.pushBehavior = pushBehavior
                animator.addBehavior(pushBehavior)
                
                // Create random angle
                let angle = Int(arc4random_uniform(20)) - 10
                
                itemBehavior = UIDynamicItemBehavior(items: [imageView])
                itemBehavior.friction = 0.3
                itemBehavior.allowsRotation = true
                itemBehavior.addAngularVelocity(CGFloat(angle), forItem: imageView)
                
                let timeOffset = Int64(0.5 * Double(NSEC_PER_SEC))
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeOffset), dispatch_get_main_queue()){
                    self.resetPicture()
                }
            } else {
                resetPicture()
            }
            
        default:
            attachmentBehavior.anchorPoint = gesture.locationInView(self.view)
            
        }
    }

}

