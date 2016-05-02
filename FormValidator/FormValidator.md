# Form Validator
Create a single view application that shows textfields for name, street address, city, state, zip code and phone number. After each field is filled out, validate the data in the field and only allow the user to move on if the data in the field is valid. Once all fields have been filled out, hide the onscreen keyboard.

## Steps to Success

### Storyboard Tasks
[x] Add six textfields to the view.
[x] Center the first textfield horizontally with the superview.
[x] Set a proportional width of the first textfield as 80% the width of the superview.
[x] Set a top space constraint on the first textfield with a value of 8 points from the top layout guide.
[x] set the placeholder text for the TextFields as [ Name, Address, City, State, Zip Code, Phone Number]
[x] Set the address and City TextFields to be equal widths of the Name TextField
[x] Align the tops of the State and Zip Code TextFields underneath the City TextField
[x] Put the Phone Number TextField underneath the State and Zip.
[x] Separate each row by 8 pts.
[x] Create properties for each TextField


### Code Tasks
[x] Set the title of the view in viewDidLoad to "Validator"
[x] Set the view controller as a delegate of UITextField.
[x] Create one method in FormValidator per TextField that will validate the contents of that TextField.
[x] following the pattern we used in class, continue checking the contents of the current TextField before moving on to the next field with resignFirstResponder and becomeFirstResponder
[x] Once you have checked and validated all of the TextFields, hide the keyboard.

### Hard Mode

[ ] Find a way to validate a city