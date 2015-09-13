//
//  ProfileViewController.swift
//  MHacks6
//
//  Created by Vasil Pendavinji on 9/12/15.
//  Copyright © 2015 Vasil Pendavinji. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, GIDSignInUIDelegate {
    let myNotificationKey = "com.dimvas.MHacks6.prof"
    let htvcNotificationKey = "com.dimvas.MHacks6.htvc"
    let delegateNotificationKey = "com.dimvas.MHacks6.delegate"
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet var name:UITextField?


    
    @IBAction func closeAction(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification", name: myNotificationKey, object: nil)

        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()

    }
    
    func notify(key:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(key, object: self)
    }
    
    func receiveNotification() {
            name!.text = appDelegate.me.fname
    }

    
    @IBAction func didTapSignOut(sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    func keyboardWillShow(sender: NSNotification) {

        self.view.frame.origin.y -= 200
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 200
    }
}
