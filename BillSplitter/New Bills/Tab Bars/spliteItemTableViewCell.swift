//
//  spliteItemTableViewCell.swift
//  BillSplitter
//
//  Created by David Ho on 4/13/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class splitItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var isForSplit: Bool?
    
    var item: itemModel! {
        didSet {
            self.updateUI()
        }
    }
    func updateUI() {
        
        self.backgroundColor = .clear
        self.layer.masksToBounds = true
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 8
        
        if let item = item {
            nameLabel.text = item.itemName
            if let _ = isForSplit {
                if item.numberOfPeopleOwned != 0 {
                    priceLabel.text = String(format: "$%.2f", item.price/Double(integerLiteral: Int64(item.numberOfPeopleOwned)))
                }
                else {
                    priceLabel.text = String(format: "$%.2f", item.price)
                }
            }
            else {
                priceLabel.text = String(format: "$%.2f", item.price)
            }
            
        }
        else {
         nameLabel.text = nil
         priceLabel.text = nil
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
