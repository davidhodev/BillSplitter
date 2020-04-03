//
//  itemModel.swift
//  BillSplitter
//
//  Created by David Ho on 4/2/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
class itemModel {
    var itemName: String
    var price: Double
    
    init(name: String, price: Double ) {
        self.itemName = name
        self.price = price
    }
}
