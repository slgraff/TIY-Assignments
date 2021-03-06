//
//  AppDelegate.swift
//  NSCodingPartDeux
//
//  Created by Steve Graff on 5/12/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let jeffUser: UserProfile = UserProfile(name: "Jeff",
                                                 userID: "jtligon",
                                                 password: "nongonnashowyou",
                                                 profile: NSURL(string: "https://www.google.com")!)
        
        let dougUser = UserProfile(name: "Doug",
                                   userID: "doug",
                                   password: "javapassword",
                                   profile: NSURL(string: "https://www.oracle.com")!)
        
        
        // Create array of users
        let userArray = [jeffUser, dougUser]
        
        // Create new user defaults
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Grab last user stored in userDefaults
        if let lastUserData = defaults.objectForKey("lastUser") as? NSData {
            let lastUser = NSKeyedUnarchiver.unarchiveObjectWithData(lastUserData)  // lastUser only exists inside here
            
            if lastUser?.name == "Jeff" {
                print("We got Jeff!")
            } else {
                print("We got \(lastUser!.name!)")
            }
        }
        
        // Pick a random user
        let randomPick = arc4random() % 2
        
        let thisUser = userArray[Int(randomPick)]
        
        let data:NSData = NSKeyedArchiver.archivedDataWithRootObject(thisUser)
        
        // Set defaults to be random user
        defaults.setObject(data, forKey: "lastUser")
        
        
        // Archive the file to a local file, need to specify valid path
        let pathArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let pathString = pathArray.last
        let filePathString = pathString! + "/localStorage.plist"
        
        NSKeyedArchiver.archiveRootObject(thisUser, toFile: filePathString)
        
        
        return true
    }

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


}

