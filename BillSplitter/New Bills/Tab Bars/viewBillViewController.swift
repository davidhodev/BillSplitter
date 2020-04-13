//
//  viewBillViewController.swift
//  BillSplitter
//
//  Created by David Ho on 4/8/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class viewBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var receipt: receiptModel?
    
    @IBOutlet weak var viewTableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: "viewBillViewController", bundle: nil)
    }
    
           
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        self.viewTableView.dataSource = self
        self.viewTableView.delegate = self
        self.viewTableView.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        self.viewTableView.register(UINib(nibName: "addMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "addMemberTableViewCell")
        self.viewTableView.separatorColor = .clear
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.receipt?.getMembers().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMemberTableViewCell", for: indexPath) as! addMemberTableViewCell
        cell.member = receipt?.getMembers()[indexPath.row]
        return cell
    }
}
