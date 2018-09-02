//
//  OrderPartsModel.swift
//  SmartFix
//
//  Created by mac on 7/25/18.
//  Copyright © 2018 tr. All rights reserved.
//

import Foundation

class OrderPartsModel{
    
    
    var name : String=""
    var warrenty:Int
    var price:Int
    init(name:String,warrenty:Int,price:Int) {
        
        self.name=name
        self.warrenty=warrenty
        self.price=price
        
    }
}
