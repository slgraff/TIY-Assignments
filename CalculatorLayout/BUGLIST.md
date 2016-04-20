###List of bugs in Calculator app

1. When pressing an operator key the display is set to 0
	* To fix, don't set the display to 0 at this point

2. Display is displaying too many trailing zeros when displaying result of calculation
	* Use string formatting to set the number of trailing zeros in the float that is displayed

3. Calculator is not clearing the display after entering an operator and the second operand.
	* Retain the value for the first operand, then set the display to the second entered operand

4. Calculator is not able to perform calculation. Always get 'Invalid' after clicking on = sign.
	* When clicking on operator button the value in display should be saved, then set userIsTypingNumber to true. When handling operand key presses, check to see if  is true.

5. When pressing an operand, then immediately equals get 'Invalid' error in display
	* Check equalTapped method, set breakpoints before and after to see what's happening. May need to check for values in operand1 and operand1 that are not nil or "". If either is empty, do nothing (behavior of iOS calculator). Handle all inappropriate presses of equals.

6. When pressing operand, operator, operand then another operand, needs to insert an implied '=' operand, then grab the pressed operand.

