//
//  addMemberTableViewCell.swift
//  BillSplitter
//
//  Created by David Ho on 4/7/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class addMemberTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var member: memberModel! {
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
        
        if let member = member {
            nameLabel.text = member.memberName
        }
        else {
         nameLabel.text = nil
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
