//
//  Caretaker.swift
//  MHacks6
//
//  Created by Vasil Pendavinji on 9/12/15.
//  Copyright © 2015 Vasil Pendavinji. All rights reserved.
//

import Foundation

class Location {
    var locationId:Int = 0
    var city:String = ""
    var country:String = ""
    var region:String = ""
}

class Caretaker {
    var caretakerId: Int = 0
    var fname: String = ""
    var lname: String = ""
    var town:String = ""
    var state:String = ""
    var zip:Int = 0
    var lat:Float = 0.0
    var lon:Float = 0.0
    var radius:Int = 0
    var language:String = ""
    var experience:String = ""
    var locationId:Int = 0
    var gender:String = ""
    var profPic:String = ""
    var googleId:String = ""
    var email:String = ""
    var canCook:Bool = false
    var canClean:Bool = false
    var canDrive:Bool = false
    var skillsExpl:String = ""
    var bio:String = ""
    var priceRange:String = ""
    var petsAllowed:Bool = false
    
}

class Carereceiver {
    var customerId: Int = 0
    var fname: String = ""
    var lname: String = ""
    var age:Int = 0
    var town:String = ""
    var state:String = ""
    var zip:Int = 0
    var lat:Float = 0.0
    var lon:Float = 0.0
    var language:String = ""
    var locationId:Int = 0
    var gender:String = ""
    var profPic:String = ""
    var googleId:String = ""
    var email:String = ""

}
