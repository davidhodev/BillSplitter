//
//  billModel.swift
//  BillSplitter
//
//  Created by David Ho on 2/8/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation

class billModel {
    var restaurant: String
    
    init(restaurant: String) {
        self.restaurant = restaurant
    }
    
    static func getPreviousBills() -> [billModel] {
        return [billModel(restaurant: "Broccolino"), billModel(restaurant: "World Famous Deli"), billModel(restaurant: "Born Thai")]
    }
}
