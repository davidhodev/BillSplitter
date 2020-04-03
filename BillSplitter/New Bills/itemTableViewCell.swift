//
//  itemTableViewCell.swift
//  BillSplitter
//
//  Created by David Ho on 4/2/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class itemTableViewCell: UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var item: itemModel! {
        didSet {
            self.updateUI()
        }
    }
    func updateUI() {
        if let item = item {
            nameLabel.text = item.itemName
            priceLabel.text = String(format: "$%.2f", item.price)
        }
        else {
         nameLabel.text = nil
         priceLabel.text = nil
        }
    }
}
