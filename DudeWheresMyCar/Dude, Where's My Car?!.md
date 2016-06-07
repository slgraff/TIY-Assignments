## Dude, Where's My Car?!

Build an iPhone app that allows the user to drop a pin on demand to mark where their car has been parked. Also allow the user to enter a short description or name for this location. Save this information using NSCoding to NSUserDefaults. When the app is relaunched, if a pin has been saved, the app will pull the pin in from NSUserDefaults and show it on the map. Include a separate marker denoting the user's current location.

## Steps to Success

### Storyboard Tasks

* [x] Create a view controller that shows a navigation bar.
* [x] Add a UIMapView to the view controller's view. Make it span the entire view.
* [x] Add a button (possibly in the navbar?) to allow the user to drop a pin at their current location.

### Code Tasks

* [x] Set up your view controller to track the user's current location.
* [x] Create an object to model a particular location and the title or description the user entered for that location.
* [x] Configure the above object to be encoded/decoded using NSCoding.
* [x] Add code to the AppDelegate to allow for encoding/decoding on shutdown/launch.
* [x] Configure the view controller to pull the data in from NSUserDefaults if it exists, and then display the pin on the map.