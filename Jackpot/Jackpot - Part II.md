### Jackpot - Part II

* [ ] Fix your delegate method to pass the array back to the tickets TableViewController
* [ ] Finish determining if all the numbers have been picked.
	* Create an allNumbersPicked method to check if all numbers have been picked. Tom this when picking number check to see if all other numbers picked.
* [ ] If a number has been chosen, remove the choice from the other components of the UIPickerView
	* Everybody had problems with this, nested ifs
	* How to remove row and refresh picker view
* [ ] Create a button for a random winner (you can choose random numbers and animate the UIPickerView, or you can use your previous quickPick method)
* [ ] Sort the winning tickets based on the payout amount.
	* Inside Tickets class inside createPick use NSSortDescriptor to sort the picks.