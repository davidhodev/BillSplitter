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
    var numberOfPeopleOwned: Int
    
    init(name: String, price: Double ) {
        self.itemName = name
        self.price = price
        self.numberOfPeopleOwned = 0
    }
}

extension itemModel: Equatable {
    static func == (lhs: itemModel, rhs: itemModel) -> Bool {
        return
            lhs.price == rhs.price &&
            lhs.itemName == rhs.itemName &&
            lhs.numberOfPeopleOwned == rhs.numberOfPeopleOwned
    }
}
