//
//  getReceiptModel.swift
//  BillSplitter
//
//  Created by David Ho on 4/14/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
struct Item {
    let itemName: String
    let numberOfPeopleOwned: Int
    let price: String
}

struct getReceiptModel: Codable {
    let itemsList: [itemModel]
    let membersList: [memberModel]
    
}
     
