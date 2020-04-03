//
//  addItemView.swift
//  BillSplitter
//
//  Created by David Ho on 3/31/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class addItemView: UIViewController {
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    var delegate: addItemDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: "addItemView", bundle: nil)
    }
    
           
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        priceTextField.becomeFirstResponder()
        priceTextField.keyboardType = .numbersAndPunctuation
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        delegate?.addItem(name: itemNameTextField.text ?? "", price: Double(priceTextField.text!)!)
        self.dismiss(animated: true, completion: nil)
    }
}
protocol addItemDelegate: newBillViewController {
    func addItem(name: String, price: Double)
}
