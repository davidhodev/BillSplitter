//
//  viewBillViewController.swift
//  BillSplitter
//
//  Created by David Ho on 4/8/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit

class viewBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, saveDelegate {
    
    
    
    var receipt: receiptModel?
    var saveAvailable: Bool = true
    let userDefaults = UserDefaults.standard
    var delegate: saveDelegate?
    
    @IBOutlet weak var viewTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
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
        
        self.viewTableView.register(UINib(nibName: "addMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "addMemberTableViewCell")
        viewTableView.register(UINib(nibName: "splitItemTableViewCell", bundle: nil), forCellReuseIdentifier: "splitItemTableViewCell")
        
        receipt?.calculateAmountOwed()
        viewTableView.reloadData()
        
        if saveAvailable {
            saveButton.isHidden = false
        }
        else {
            saveButton.isHidden = true
        }
        
        self.delegate = self
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (receipt?.getMembers().count)!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = self.receipt?.getMembers()[section].items.count {
            return rows
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "splitItemTableViewCell", for: indexPath) as! splitItemTableViewCell
        cell.isForSplit = true
        cell.item = receipt?.getMembers()[indexPath.section].items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:18))
        let label = UILabel(frame: CGRect(x:10, y:10, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Verdana", size: 20)
        label.text = receipt?.getMembers()[section].memberName
        label.textColor = .white
        
        let labelPrice = UILabel(frame: CGRect(x:10, y:40, width:tableView.frame.size.width, height:18))
        labelPrice.font = UIFont(name: "Verdana-Bold", size: 20)
        if let amt = receipt?.getMembers()[section].amountOwed {
            labelPrice.text = String(format: "$%.2f", amt)
        }
        
        labelPrice.textColor = .white
        
        
        view.addSubview(label);
        view.addSubview(labelPrice);
        view.backgroundColor = UIColor(red:0.41, green:0.10, blue:0.88, alpha:1.00)
        return view
    }
    
    func save(restaurant: String) {
        self.receipt?.addRestaurant(restaurant: restaurant)
        
        let encoder = JSONEncoder()
                 if let data = try? encoder.encode(receipt) {
                let string = String(data: data, encoding: .utf8)!
                
                if  (userDefaults.integer(forKey: "receiptCount")) > 0{
                    var newReceiptCount = userDefaults.integer(forKey: "receiptCount")
                    newReceiptCount += 1
                    userDefaults.set(newReceiptCount, forKey: "receiptCount")
                    userDefaults.set(data, forKey: "receipts\(newReceiptCount)")
                }
                else {
                    userDefaults.set(1, forKey: "receiptCount")
                    userDefaults.set(data, forKey: "receipts1")
                }
                userDefaults.synchronize()
                
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let vc = saveView()
        vc.delegate = self
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    
}
