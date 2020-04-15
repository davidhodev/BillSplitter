//
//  previousBillsCollectionViewCell.swift
//  BillSplitter
//
//  Created by David Ho on 2/8/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class previousBillsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var totalPaidLabel: UILabel!
    @IBOutlet weak var amountPaidLabel: UILabel!
    
    var receipt: receiptModel! {
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI() {
        if let receipt = receipt {
            if let resName = receipt.restaurantName {
                restaurantLabel.text = receipt.restaurantName
            }
            else {
                restaurantLabel.text = "Unavailable"
            }
            
            amountPaidLabel.text = String(format: "$%.2f", receipt.getMembers()[0].amountOwed)
            
            var totalPaid: Double = 0
            for item in receipt.itemsList {
                totalPaid += item.price
            }
            totalPaidLabel.text = String(format: "$%.2f", totalPaid)
            
            
        }
        else {
         restaurantLabel.text = nil
        }
    }
}

class emptyPreviousBill: UICollectionViewCell {
    @IBOutlet weak var emptyLabel: UILabel!
    
}
