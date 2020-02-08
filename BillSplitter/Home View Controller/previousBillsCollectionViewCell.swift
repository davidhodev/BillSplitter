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
    var bill: billModel! {
           didSet {
               self.updateUI()
           }
       }
       
       
       func updateUI() {
           if let bill = bill {
            restaurantLabel.text = bill.restaurant
           }
           else {
            restaurantLabel.text = nil
           }
       }
}
