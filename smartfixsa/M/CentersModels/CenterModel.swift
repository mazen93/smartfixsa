//
//  CenterModel.swift
//  SmartFix
//
//  Created by tr on 7/17/18.
//  Copyright © 2018 tr. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CentersModel {
    
     var photo : String = ""
     var name : String = ""
     var addres : String = ""
    var service:String=""
    var lat :Double=0
    var lng:Double=0

    init(name:String,addres:String,service:String,photo:String,lat:Double,lng:Double) {
        self.photo=photo
        self.name=name
        self.addres=addres
        self.service=service
        self.lat=lat
        self.lng=lng
   }
}
    


    

