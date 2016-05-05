## Get To Done

A basic CRUD (Create/Restore/Update/Delete) To Do style app, with Core Data backing.

Make a To Do App, needs to run and be running on iPhone tomorrow to show to class. 


### Basic Features
* To Do app tracks items with following properties:
	* [x] Title
	* [x] Detail
	* [x] Due date
	* [x] Ability to mark it as done (UISwitch)
* [x] Create a new To Do item, sets default title, detail, due date
* [x] View an existing To Do Item title, detail, due date
	* [ ] Cancel and Save button should be disabled until user begins editing
* [x] Use Save button to save changed to text field, text view
* [ ] Values of due date and done switch saved immediately
* [x] Edit title, detail text of a To Do item
	* [x] Handle multiple edits of item in detail view
	* [x] Set enabled status for Cancel, Save buttons appropriately
	* [ ] Hide keyboard when clicking outside of field/view
* [ ] Change the due date for a To Do item
	* [ ] Use a UIDatePicker
	* [ ] Display the date in a user friendly format
* [ ] Provide support for portrait and landscape


### Additional Features
* [x] Set lighter disabled color for Cancel button when disabled
* [ ] Alert the user when an item is due
	* [ ] Change the appearance of To Do item in list (background color, etc.) Due today yellow, overdue red??
	* [ ] Be able to 'snooze' the item, setting a due date in future
* [ ] Use DataDetectors in detail field to detect phone numbers, URLs
* [ ] Add a photo to the To Do item, take picture or select from Photos library
