//
//  AppDelegate.swift
//  MHacks6
//
//  Created by Vasil Pendavinji on 9/12/15.
//  Copyright © 2015 Vasil Pendavinji. All rights reserved.
//

import UIKit
import SwiftyJSON


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    let myNotificationKey = "com.dimvas.MHacks6.delegate"
    let htvcNotificationKey = "com.dimvas.MHacks6.htvc"
    let profNotificationKey = "com.dimvas.MHacks6.prof"


    var window: UIWindow?
    var me: Carereceiver = Carereceiver()
    var caretakers = [Caretaker]()
    
    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Initialize sign-in
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "239469958871-kgrm5236242vhsrusoer3ia77bbluths.apps.googleusercontent.com"
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification", name: myNotificationKey, object: nil)

        
        getData()
        
        return true
    }
    func notify(key:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(key, object: self)
    }
    
    func receiveNotification() {
        //do something
    }
    
    func getData(){
        let request = NSURLRequest(URL: NSURL(string: "http://caremaker.tk/get/caretaker?town=champaign&state=il&zip=61820")!)
        //API call
        let session = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            // Handle incoming data like you would in synchronous request
            if let reply = data {
                let json = JSON(data: reply)
                //let stops = json["stops"]
                
                for item in json{
                    print(item)
                    let caretaker:Caretaker = Caretaker()
                    caretaker.lat = item.1["x_coord"].float!
                    caretaker.lon = item.1["y_coord"].float!
                    caretaker.fname = item.1["first_name"].string!
                    caretaker.lname = item.1["last_name"].string!
                    caretaker.town = item.1["town"].string!
                    caretaker.state = item.1["state"].string!
                    caretaker.zip = item.1["zip"].int!
                    caretaker.radius = item.1["radius"].int!
                    caretaker.language = item.1["language"].string!
                    caretaker.experience = item.1["experience"].string!
                    caretaker.gender = item.1["gender"].string!
                    caretaker.profPic = item.1["pic_url"].string!
                    caretaker.email = item.1["email"].string!
                    caretaker.canCook = item.1["can_cook"].boolValue
                    caretaker.canDrive = item.1["can_drive"].boolValue
                    caretaker.canClean = item.1["can_clean"].boolValue
                    caretaker.skillsExpl = item.1["skills_explanation"].string!
                    caretaker.bio = item.1["bio"].string!
                    caretaker.priceRange = item.1["price_range"].string!
                    caretaker.petsAllowed = item.1["pets_allowed"].boolValue
                    
                    self.caretakers.append(caretaker)
                    
                }
            }
            for i in 1...(self.caretakers.count-1) {
                for j in 1...(self.caretakers.count-i) {
                    if(self.caretakers[j-1].radius > self.caretakers[j].radius) {
                        (self.caretakers[j-1], self.caretakers[j]) = (self.caretakers[j], self.caretakers[j-1])
                    }
                }
            }
        self.notify(self.htvcNotificationKey)

        }
        
      
        session.resume()


    }
    
    func application(application: UIApplication,
        openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            return GIDSignIn.sharedInstance().handleURL(url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func signIn(signIn: GIDSignIn, didSignInForUser user: GIDGoogleUser,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                me.googleId = user.userID                  // For client-side use only!
                me.token = user.authentication.idToken // Safe to send to the server
                me.fname = user.profile.name
                me.email = user.profile.email
                me.profPic = user.profile.imageURLWithDimension(100)
                notify(profNotificationKey)
                print("UsID: " + me.googleId + " name: " + me.fname + " email: " + me.email)
            } else {
                print("\(error.localizedDescription)")
            }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
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

