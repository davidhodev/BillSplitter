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
    //    var bill: billModel! {
//           didSet {
//               self.updateUI()
//           }
//       }
//
//
//       func updateUI() {
//           if let bill = bill {
//            restaurantLabel.text = bill.restaurant
//           }
//           else {
//            restaurantLabel.text = nil
//           }
//       }
    
    var receipt: receiptModel! {
        didSet {
            self.updateUI()
        }
    }
    
    
    func updateUI() {
        if let receipt = receipt {
            restaurantLabel.text = "Text"
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
