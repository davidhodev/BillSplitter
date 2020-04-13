//
//  addMembersViewController.swift
//  BillSplitter
//
//  Created by David Ho on 4/7/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit
class addMembersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, addMemberDelegate {
    
    
    @IBOutlet weak var membersTableView: UITableView!
    var receipt: receiptModel?
    var delegate: addMemberDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        self.membersTableView.delegate = self
        self.membersTableView.dataSource = self
        self.membersTableView.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        self.membersTableView.register(UINib(nibName: "addMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "addMemberTableViewCell")
        self.membersTableView.separatorColor = .clear
        
        if receipt?.getMembers().count == 0 {
        }
        
        self.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "addMembersViewController", bundle: nil)
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let membersCount = receipt?.getMembers().count {
            return membersCount
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMemberTableViewCell", for: indexPath) as! addMemberTableViewCell
        cell.member = receipt?.getMembers()[indexPath.row]
        return cell
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.membersTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.receipt?.deleteMember(index: indexPath.row)
            self.membersTableView.reloadData()
        }
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        let vc = addMemberView()
        vc.delegate = self
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    
    func addMember(name: String) {
        self.receipt?.addMember(name: name)
        self.membersTableView.reloadData()
        
    }
    
    
}
