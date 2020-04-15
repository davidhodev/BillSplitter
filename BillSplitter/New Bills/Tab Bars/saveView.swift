//
//  saveView.swift
//  BillSplitter
//
//  Created by David Ho on 4/15/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class saveView: UIViewController {
    var delegate: saveDelegate?
    @IBOutlet weak var saveTextField: UITextField!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: "saveView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveTextField.becomeFirstResponder()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        
        self.delegate?.save(restaurant: saveTextField.text ?? "Unavailable")
        self.dismiss(animated: true, completion: nil)
    }
    
}
protocol saveDelegate: viewBillViewController {
    func save(restaurant: String)
}
