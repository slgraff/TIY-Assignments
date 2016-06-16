//
//  AppDelegate.swift
//  Walkies2ElectricBoogaloo
//
//  Created by Steve Graff on 6/13/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        let fetchRequest = NSFetchRequest(entityName: "Walks")
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            if results.count == 0 {
                addTestData()
            }
        } catch {
            print("Error fetching Walks data!")
        }
        
        if let tab = window?.rootViewController as? UITabBarController {
            for child in tab.viewControllers ?? [] {
                if let child = child as? UINavigationController, top = child.topViewController {
                    if top.respondsToSelector(Selector("setManagedObjectContext:")) {
                        top.performSelector(Selector("setManagedObjectContext:"), withObject: managedObjectContext)
                    }
                }
            }
        }
        
        return true
    }
    
    
    // MARK: Add Test Data
    func addTestData() {
        guard let walksEntity = NSEntityDescription.entityForName("Walks", inManagedObjectContext: managedObjectContext), clientsEntity = NSEntityDescription.entityForName("Clients", inManagedObjectContext: managedObjectContext), dogsEntity = NSEntityDescription.entityForName("Dogs", inManagedObjectContext: managedObjectContext)
        else {
            fatalError("Could not find entity description!")
        }
        
        // Add sample Walks data
        for i in 1...10 {
            let walks = Walks(entity: walksEntity, insertIntoManagedObjectContext: self.managedObjectContext)
            
            walks.walkDate = i % 3 == 0 ? "Thursday, June 30th" : "Friday, July 1st"
            walks.walkETABegin = i % 3 == 0 ? "11:00am" : "12:00pm"
            walks.walkETAEnd = i % 3 == 0 ? "1:00pm" : "2:00pm"
        }
        
        
        // Add sample Clients data
        let johnsmith = Clients(entity: clientsEntity, insertIntoManagedObjectContext: self.managedObjectContext)
        johnsmith.name = "John Smith"
        johnsmith.address = "100 E. Main St., Durham, NC 27701"
        
        let suzy = Clients(entity: clientsEntity, insertIntoManagedObjectContext: self.managedObjectContext)
        suzy.name = "Suzy Chapstick"
        suzy.name = "330 E. Trinity Ave., Durham, NC 27701"
        
        
        // Add sample Dogs data        
        let snickers = Dogs(entity: dogsEntity, insertIntoManagedObjectContext: self.managedObjectContext)
        snickers.name = "Snickers"
        snickers.age = "12"
        snickers.size = "small"
        snickers.breed = "poodle/dacshund mix"
        
        let calvin = Dogs(entity: dogsEntity, insertIntoManagedObjectContext: self.managedObjectContext)
        calvin.name = "Calvin"
        calvin.age = "10"
        calvin.size = "small"
        calvin.breed = "maltese"
        
        let barney = Dogs(entity: dogsEntity, insertIntoManagedObjectContext: self.managedObjectContext)
        barney.name = "Barney"
        barney.age = "10"
        barney.size = "medium"
        barney.breed = "beagle/basset hound mix"
        
        saveContext()
        
    }
    
    // TODO: Change Add Test Data to populate walks, clients, dogs with info from dictionaries
    // MARK: Add Test Data
//    func addTestData() {
//        guard let entity = NSEntityDescription.entityForName("Walks", inManagedObjectContext: managedObjectContext) else {
//            fatalError("Could not find entity description!")
//        }
//        
//        
//        // Dictionary of walks
//        var walks: [String: [String:String]] = [
//            "0001": ["client":"Charlie Brown", "dogs":"Snoopy", "walkDate":"June 30, 2016", "walkETABegin":"11:00am", "walkETAEnd":"2:00pm"],
//            "0002": ["client":"Charlie Brown", "dogs":"Snoopy", "walkDate":"June 30, 2016", "walkETABegin":"1:00pm", "walkETAEnd":"2:00pm"],
//            "0003": ["client":"Charlie Brown", "dogs":"Snoopy", "walkDate":"June 30, 2016", "walkETABegin":"12:00pm", "walkETAEnd":"2:00pm"],
//            "0004": ["client":"Charlie Brown", "dogs":"Snoopy", "walkDate":"June 30, 2016", "walkETABegin":"4:00pm", "walkETAEnd":"6:00pm"],
//            "0005": ["client":"Charlie Brown", "dogs":"Snoopy", "walkDate":"June 30, 2016", "walkETABegin":"5:00pm", "walkETAEnd":"7:00pm"]
//        ]
//        
//        // Populate Core Data with walks dictionary
////        for (walkKey, walkValue) in walks {
////            let walk = Walks(entity: entity, insertIntoManagedObjectContext: self.managedObjectContext)
////            
////            walk.client = walks[walkKey].["client"]
////            
////            
////            ["client"]! as String
////            walk.dogs = theWalk["dogs"]! as String
////            walk.walkDate = walk["walkDate"]! as String
////            walk.walkETABegin = walk["walkETABegin"]! as String
////            walk.walkETAEnd = walk["walkETAEnd"]! as String
////            
////            saveContext()
////        }
//        
//        
//        
//        // Dictionary of dogs; Snoopy and his seven siblings
//        var dogs: [String: [String: String]] = [
//            "Snoopy":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Likes to lick Lucy, try to prevent him from doing so. Can walk him down to James Street Elementary School."],
//            "Spike":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Likes to wear a fedora."],
//            "Andy":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Plays the jug."],
//            "Marbles":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Be sure to put on his jogging shoes before walk. Likes to play the banjo."],
//            "Olaf":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Likes to wear a hunting cap. Plays the drums."],
//            "Belle":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Has a lace collar."],
//            "Molly":["breed":"beagle", "age":"6", "sex":"female", "size":"small", "notes":"Plays the dobro."],
//            "Rover":["breed":"beagle", "age":"6", "sex":"male", "size":"small", "notes":"Plays the mandolin."]
//        ]
//        
//        // Populate Core Data with dogs dictionary
//            
//        // Dictionary of clients
//        var clients: [String: [String: String]] = [
//            "Charlie Brown":["address":"1502 James St., Hennepin County, MN", "phone":"612-555-1212", "email":"chuck@thepeanuts.net", "securityInfo":""],
//            
//            ]
//        
//        // Populate Core Date with clients dictionary
//        
//        
//        
//        
//        
////        let jim = Person(entity: personEntity, insertIntoManagedObjectContext: managedObjectContext)
////        bob.name = "Jim Black"
////        let susie = Person(entity: personEntity, insertIntoManagedObjectContext: managedObjectContext)
////        jane.name = "Susie Chapstick"
//        
//        saveContext()
//        
//    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Steve-Graff.AppToGetCoreDataCrud" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Walkies", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }


}

