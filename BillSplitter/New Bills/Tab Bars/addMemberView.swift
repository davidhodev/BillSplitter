//
//  addMemberView.swift
//  BillSplitter
//
//  Created by David Ho on 4/7/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class addMemberView: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    var delegate: addMemberDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: "addMemberView", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        self.delegate?.addMember(name: nameTextField.text ?? "")

        self.dismiss(animated: true, completion: nil)
    }
}
protocol addMemberDelegate: addMembersViewController {
    func addMember(name: String)
}
