//
//  ViewController.swift
//  MHacks6
//
//  Created by Vasil Pendavinji on 9/12/15.
//  Copyright © 2015 Vasil Pendavinji. All rights reserved.
//

import UIKit

class CareTableViewCell : UITableViewCell {
    @IBOutlet weak var lang0: UIImageView?
    @IBOutlet var lang1: UIImageView?
    @IBOutlet var lang2: UIImageView?
    @IBOutlet var lang3: UIImageView?
    @IBOutlet var flag0: UIImageView?
    @IBOutlet var flag1: UIImageView?
    @IBOutlet var flag2: UIImageView?
    @IBOutlet var flag3: UIImageView?
    @IBOutlet var exp: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var distLabel: UILabel?

    
    func loadItem(title title: String, image: String) {
        lang0?.image = UIImage(named: image)
        lang1?.image = UIImage(named: image)
        lang2?.image = UIImage(named: image)
        lang3?.image = UIImage(named: image)
        flag0?.image = UIImage(named: image)
//        flag1?.image = UIImage(named: image)
//        flag2?.image = UIImage(named: image)
//        flag3?.image = UIImage(named: image)
        flag1?.image = nil
        flag2?.image = nil
        flag3?.image = nil
        exp?.image = UIImage(named: image)
        nameLabel?.text = title
        distLabel?.text = "2 mi"
        

    }
}


class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.estimatedRowHeight = 120
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cell = tableView.dequeueReusableCellWithIdentifier("CareCell", forIndexPath: indexPath) as! CareTableViewCell
    
    cell.setNeedsUpdateConstraints()
    cell.updateConstraintsIfNeeded()
    cell.layoutIfNeeded()

    
        cell.loadItem(title: "Bob Saget", image: "Illini")
    
    
    
        return cell
    }


}

