//
//  ViewController.swift
//  MHacks6
//
//  Created by Vasil Pendavinji on 9/12/15.
//  Copyright © 2015 Vasil Pendavinji. All rights reserved.
//

import UIKit
import Foundation

class CareTakerProfileScreen: UIStackView {
    @IBOutlet var propic: UIImageView?
    @IBOutlet weak var biotext: UITextView?
}

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var careTakerScrollView: UIScrollView!
    @IBOutlet var pro: CareTakerProfileScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pro.biotext!.text = "I'm a family man and I make crass jokes when I'm not on full house"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}