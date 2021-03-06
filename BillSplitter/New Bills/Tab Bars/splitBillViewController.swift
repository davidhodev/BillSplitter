//
//  splitBillViewController.swift
//  BillSplitter
//
//  Created by David Ho on 4/7/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class splitBillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var receipt: receiptModel?
    @IBOutlet weak var itemsTableView: UITableView!
    @IBOutlet weak var membersTableView: UITableView!
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: "splitBillViewController", bundle: nil)
    }
    
           
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self
        self.itemsTableView.dragDelegate = self
        self.itemsTableView.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        itemsTableView.register(UINib(nibName: "splitItemTableViewCell", bundle: nil), forCellReuseIdentifier: "splitItemTableViewCell")
        itemsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        itemsTableView.dragInteractionEnabled = true
        
        self.membersTableView.delegate = self
        self.membersTableView.dataSource = self
        self.membersTableView.dragDelegate = self
        self.membersTableView.dropDelegate = self
        self.membersTableView.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        self.membersTableView.register(UINib(nibName: "addMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "addMemberTableViewCell")
        membersTableView.register(UINib(nibName: "splitItemTableViewCell", bundle: nil), forCellReuseIdentifier: "splitItemTableViewCell")
        self.membersTableView.separatorColor = .clear
        membersTableView.dragInteractionEnabled = true
        
        membersTableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == membersTableView {
            if let membersCount = receipt?.getMembers().count {
                return membersCount + 1
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == membersTableView {
            if section > 0 {
                if let itemsCount = receipt?.getMembers()[section-1].items.count {
                    return itemsCount
                }
            }
            
            return 0
        }
        else {
            if let receiptItemsCount = receipt?.getItems().count {
                return receiptItemsCount
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == membersTableView {
            if (section == 0) {
                let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:18))
                let label = UILabel(frame: CGRect(x:10, y:5, width:tableView.frame.size.width, height:18))
                label.font = UIFont(name: "Verdana", size: 17)
                label.text = "Everyone"
                label.textColor = .white
                view.addSubview(label);
                view.backgroundColor = UIColor(red:0.41, green:0.08, blue:0.88, alpha:1.00)
                return view
                
            }
            let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:18))
            let label = UILabel(frame: CGRect(x:10, y:5, width:tableView.frame.size.width, height:18))
            label.font = UIFont(name: "Verdana", size: 17)
            label.text = receipt?.getMembers()[section-1].memberName
            label.textColor = .white
            view.addSubview(label);
            view.backgroundColor = UIColor(red:0.41, green:0.08, blue:0.88, alpha:1.00)
            return view
        }
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:18))
        let label = UILabel(frame: CGRect(x:10, y:5, width:tableView.frame.size.width, height:18))
        label.font = UIFont(name: "Verdana", size: 17)
        label.text = "Items"
        view.addSubview(label);
        view.backgroundColor = UIColor.clear;
        return view
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == membersTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "splitItemTableViewCell", for: indexPath) as! splitItemTableViewCell
            cell.isForSplit = true
            cell.item = receipt?.getMembers()[indexPath.section - 1].items[indexPath.row]
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "splitItemTableViewCell", for: indexPath) as! splitItemTableViewCell
            cell.isForSplit = false
            cell.item = receipt?.getItems()[indexPath.row]
            
            return cell
        }
    }

}

extension splitBillViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let item = receipt?.getItems()[indexPath.row]
            
        let itemProvider = NSItemProvider()
        itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String, visibility: .all) { completion in
            let data = item?.itemName.data(using: .utf8)
            completion(data, nil)
            return nil
        }
        
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = receipt?.getItems()[indexPath.row]
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == itemsTableView {
            return 90
        }
        return 90
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
}

extension splitBillViewController: UITableViewDropDelegate {

    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSString.self)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destination: IndexPath
        if let index = coordinator.destinationIndexPath {
            destination = index
            
        }
        else {
            destination = IndexPath(row: membersTableView.numberOfRows(inSection: membersTableView.numberOfSections - 1), section: membersTableView.numberOfSections - 1)
        }
        
        for elem in coordinator.items {
            let item = elem.dragItem.localObject as? itemModel
            
            DispatchQueue.main.async {
                if (coordinator.destinationIndexPath?.section == 0) {
                    for count in 1...self.membersTableView.numberOfSections - 1 {
                        print(count)
                        print(self.membersTableView.numberOfRows(inSection: count))
                        self.receipt?.getMembers()[count-1].addItem(item: item!)
                        self.membersTableView.insertRows(at: [IndexPath(row: self.membersTableView.numberOfRows(inSection: count), section: count)], with: .automatic)
                        
                        self.receipt?.recalculateMembersCost()
                        self.membersTableView.reloadData()
                    }
                }
                else {
                    
                    self.receipt?.getMembers()[destination.section-1].addItem(item: item!)
                    self.membersTableView.insertRows(at: [destination], with: .automatic)
                    self.receipt?.recalculateMembersCost()
                    self.membersTableView.reloadData()
                    
                }
            }
        }
        
    }
    
}
