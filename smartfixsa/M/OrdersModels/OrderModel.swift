//
//  OrderModel.swift
//  SmartFix
//
//  Created by mac on 7/22/18.
//  Copyright © 2018 tr. All rights reserved.
//

import Foundation

import Realm
import RealmSwift

class OrderModel {
    
    
    var phone:String=""
    var id:String=""


    
    init(phone:String,id:String) {
        self.phone=phone
        self.id=id
    }
    
}


