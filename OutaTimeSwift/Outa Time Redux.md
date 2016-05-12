## Outa Time Redux

Re-create the Outa Time app using Swift instead of Objective-C.

### Steps to Success

#### Storyboard Tasks

* [x] The time circuits view should be embedded in a navigation controller
* [x] All label groups should be centered horizontally and 20 points apart. The actual readout labels should also use the custom font "digital-7".
	* [x] Below the labels for the destination time, there should be a set of labels for "present time"
		* [x] Choose a lime green/yellow color for this label
	* [x] Below the present time labels, there should be a set for "last time departed"
		* [x] Choose an orange color for this label
* [x] Also centered horizontally and 20 pts below the time labels, there should be a "CURRENT SPEED" label group. The second label that displays the speed should read "0 MPH"
	* [x] The actual speed label should be red in color
* [x] All relevant labels need to be wired to their associated properties

* [x] Below all the labels, there should be 2 buttons, also centered horizontally and spaced 20 pts apart from both the other labels and each other
	* [x] These buttons should be named "SET DESTINATION TIME" and "TRAVEL BACK"
	* [x] The buttons should both be teal in color
	* [x] These buttons should be wired to their appropriate IBActions or segues
		* [x] The segue for SET DESTINATION TIME should have an identifier of "destinationTimeSegue"

* [ ] The the date picker view contains a date picker. This UI object should be centered both horizontally and vertically in the view. Its leading and trailing space should also hug the left and right edges of its superview.
* [x] The the date picker view should be have a custom class of "DestinationTimeViewController"
* [ ] The date picker should be wired up to its associated property

#### Code Tasks

* [ ] 1. Add variables.
* [x] Set the title.
* [x] Initialize the date formatter.
* [x] Set the date formatter's date format.
* [x] Set the presentTimeLabel to the current date using the date formatter.
* [x] Set the current speed variable to 0.
* [x] Set the speed label to "% MPH", with % being the current speed.
* [x] Set the lastTimeDeparted label.
* [ ] 9. Set the TimeCircuitsViewController class as implementing the delegate for the date picker.
* [ ] 10. Set the DatePickerViewController object's delegate as the TimeCircuitsViewController object.
* [ ] 11. Call the delegate method to inform the delegate of the new date chosen by the user.
* [ ] 12. Set the destinationTimeLabel with the date received from the picker view controller using the date formatter object.
* [ ] 13. Call the method to start the timer.
* [ ] 14. Check to see if the timer object is nil. There is a shorthand for that.
* [ ] 15. Instantiate the timer object for a 0.1 sec time interval. Set it to fire the method that updates the speed label.
* [ ] 16. Stop the timer and set it to nil.
* [ ] 17. Check if the current speed variable has reached 88. We want to execute the block inside the if if we HAVEN'T reached 88.
* [ ] 18. Increment the current speed variable by 1.
* [ ] 19. Update the speed label with the current speed.
* [ ] 20. Since the speed has reached at least 88, stop the timer.
* [ ] 21. Update the value of the lastTimeDepartedLabel with the value from the presentTimeLabel.
* [ ] 22. Update the value of the presentTimeLabel with the value from the destinationTimeLabel.
* [ ] 23. Reset the value of the current speed variable to 0.
