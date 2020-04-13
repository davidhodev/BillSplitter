//
//  memberModel.swift
//  BillSplitter
//
//  Created by David Ho on 4/7/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
class memberModel {
    var memberName: String
    var amountOwed: Double
    var items: [itemModel]
    
    init(name: String, price: Double ) {
        self.memberName = name
        self.amountOwed = price
        self.items = []
    }
    
    func addItem(item: itemModel) {
        self.items.append(item)
    }
}
