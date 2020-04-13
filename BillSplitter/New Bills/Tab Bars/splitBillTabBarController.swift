//
//  splitBillTabBarController.swift
//  BillSplitter
//
//  Created by David Ho on 4/7/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit
class splitBillTabBarController: UITabBarController{
    var receipt: receiptModel! {
        didSet {
            let addMembersVC = addMembersViewController()
            addMembersVC.receipt = self.receipt
            addMembersVC.tabBarItem.title = "Add Members"
            
            
            let splitBillVC = splitBillViewController()
            splitBillVC.receipt = self.receipt
            splitBillVC.tabBarItem.title = "Split Bill"
            
            let viewBillVC = viewBillViewController()
            viewBillVC.receipt = self.receipt
            viewBillVC.tabBarItem.title = "View Bill"
            
            self.viewControllers = [addMembersVC, splitBillVC, viewBillVC]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "splitTabBarController", bundle: nil)
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func passReceipt(receipt: receiptModel) {
        self.receipt = receipt
    }
}

