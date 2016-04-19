###List of bugs in Calculator app

1. When pressing an operator key the disply is set to 0
	* To fix, don't set the display to 0 at this point

2. Display is displaying too many trailing zeros when displaying result of calculation
	* Use string formatting to set the number of trailing zeros in the float that is displayed

3. Calculator is not clearing the display after entering an operator and the second operand.
	* Retain the value for the first operand, then set the display to the second entered operand

4. Calculator is not able to perform calculation. Always get 'Invalid' after clicking on = sign.
	* When clicking on operator button the value in display should be saved, then set userIsTypingNumber to true. When handling operand key presses, check to see if  is true.
