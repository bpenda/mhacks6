//
//  ViewController.swift
//  MHacks6
//
//  Created by Vasil Pendavinji on 9/12/15.
//  Copyright © 2015 Vasil Pendavinji. All rights reserved.
//

import CoreLocation
import UIKit

struct TableData {
    static var cell:Int = 0
}

class CareTableViewCell : UITableViewCell {
    @IBOutlet weak var lang0: UIImageView?
    @IBOutlet var lang1: UIImageView?
    @IBOutlet var lang2: UIImageView?
    @IBOutlet var lang3: UIImageView?
    @IBOutlet var flag0: UILabel?
    @IBOutlet var flag1: UILabel?
    @IBOutlet var flag2: UILabel?
    @IBOutlet var flag3: UILabel?
    @IBOutlet var exp: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var distLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?

    
    func loadItem(title title: String, image: String, num:Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        if(!appDelegate.caretakers[num].petsAllowed )
        {
            lang0?.alpha = 0.1
        }
        if(!appDelegate.caretakers[num].canDrive )
        {
            lang1?.alpha = 0.1
        }
        if(!appDelegate.caretakers[num].canClean )
        {
            lang2?.alpha = 0.1
        }
        if(!appDelegate.caretakers[num].canCook )
        {
            lang2?.alpha = 0.1
        }

        flag0?.text = "🇺🇸"
        
//        flag1?.image = UIImage(named: image)
//        flag2?.image = UIImage(named: image)
//        flag3?.image = UIImage(named: image)
        flag1?.text = nil
        flag2?.text = nil
        flag3?.text = nil
        if(appDelegate.caretakers[num].language == "German")
        {
            flag1?.text = "🇩🇪"
        }
        if(appDelegate.caretakers[num].language == "Italian")
        {
            flag1?.text = "🇮🇹"
        }
        if(appDelegate.caretakers[num].language == "French")
        {
            flag1?.text = "🇫🇷"
        }
  
        if(appDelegate.caretakers[num].language == "Spanish")
        {
            flag1?.text = "🇦🇷"
        }
        if(appDelegate.caretakers[num].language == "Albanian")
        {
            flag1?.text = "🇦🇱"
        }
        if(appDelegate.caretakers[num].language == "Ukrainian")
        {
            flag1?.text = "🇺🇦"
        }
        nameLabel?.text = title
        exp?.text = appDelegate.caretakers[num].experience + "yrs"
        priceLabel?.text = "$" + appDelegate.caretakers[num].priceRange
        distLabel?.text = (appDelegate.caretakers[num].radius as NSNumber).stringValue + " mi"
        

    }
}


class HomeTableViewController: UITableViewController , CLLocationManagerDelegate{
    var manager:CLLocationManager!
    var location : CLLocation!
    let myNotificationKey = "com.dimvas.MHacks6.htvc"
    let delegateNotificationKey = "com.dimvas.MHacks6.delegate"
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var caretakers = [Caretaker]()
    var length = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        self.manager = CLLocationManager()
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestAlwaysAuthorization()
        self.manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.estimatedRowHeight = 120
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification", name: myNotificationKey, object: nil)
        caretakers = appDelegate.caretakers
        length = caretakers.count
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    
    func notify(key:String) {
        NSNotificationCenter.defaultCenter().postNotificationName(key, object: self)
    }

    func receiveNotification() {
        caretakers = appDelegate.caretakers
        length = caretakers.count
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        print("caretakers length: " +  (caretakers.count as NSNumber).stringValue)
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations : [CLLocation]){
        manager.stopUpdatingLocation()
        self.location = locations[0] as CLLocation
                print("Location: ")
                print(location)
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error:" + error.localizedDescription)
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return length
    }
    
    
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cell = tableView.dequeueReusableCellWithIdentifier("CareCell", forIndexPath: indexPath) as! CareTableViewCell
    
    cell.setNeedsUpdateConstraints()
    cell.updateConstraintsIfNeeded()
    cell.layoutIfNeeded()

    
    cell.loadItem(title: caretakers[indexPath.row].fname + " " + caretakers[indexPath.row].lname, image: "Illini", num:indexPath.row)
    
    
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        TableData.cell = indexPath.row
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
       
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }


}

