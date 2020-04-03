//
//  receiptModel.swift
//  BillSplitter
//
//  Created by David Ho on 4/2/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
class receiptModel {
    var itemsList: [itemModel]
    
    init() {
        self.itemsList = []
    }
    
    func getItems() -> [itemModel] {
        return itemsList
    }
    
    func addItem(name: String, price: Double) {
        itemsList.append(itemModel(name: name, price: price))
    }
}
