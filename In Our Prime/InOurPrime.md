# In Our Prime

A prime number is a number that can be evenly divided by 1 and itself. Primes are useful for all sorts of things, but how do we check if a number is prime?

### Storyboard Tasks
* [ ] Create an intuitive layout for a textfield, a button and a label.
* [ ] Create an intuitive way to select which of the PrimeBrain functions you want the button to perform.

### Code Challenge
* [x] Create a class called PrimeBrain
* [x] Create a method in PrimeBrain that takes an NSUInteger and returns YES if prime, and NO if not prime.
* [x] Create a method in PrimeBrain that takes an NSUInteger and returns an array containing all of the prime factors of that number.
* [x] Create a method in PrimeBrain that takes two numbers, gets the prime factors of each of those, then takes the two NSArrays and finds the largest common number contained in them.


## BUG LIST

* [x] isPrimeNumber is saying that 25 is prime
	* FIXED: While loop inside isPrimeNumber was checking for ((counter * counter) < primeCandidate), changed to <= which fixed bug.
* [x] On first run, if user does not change picker from initial value the picker selection is not being detected
	* FIXED: Initialized variable _pickerSelection = @"Prime number";
* [x] The value of primeFactors array is getting returned as null.
* [ ] The Largest Prime Factors is not working. Accepts input but returns 0.00 as largest prime factor for 10 and 25.
* [x] primeFactors returns only 2 as factor of 10.
	* FIXED: While loop inside primeFactors was checking for i < (theNumber / 2), changed to i <= (theNumber / 2)