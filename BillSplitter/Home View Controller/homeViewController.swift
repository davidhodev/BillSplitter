//
//  homeViewController.swift
//  BillSplitter
//
//  Created by David Ho on 2/8/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import UIKit

class homeViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var previousBillsCollectionView: UICollectionView!
    
    @IBOutlet weak var newBillButton: UIButton!
    
    var previousBills: [billModel] = billModel.getPreviousBills()
    var previousReceipts: [receiptModel] = []
    var previousReceiptsData = UserDefaults.standard.data(forKey: "receipts")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        previousBillsCollectionView.delegate = self
        previousBillsCollectionView.dataSource = self
    
        previousBillsCollectionView.isUserInteractionEnabled = true
        previousBillsCollectionView.register(UINib(nibName: "previousBillsCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "previousBillsCollectionViewCell")
        previousBillsCollectionView.register(UINib(nibName: "emptyPreviousBill", bundle:nil), forCellWithReuseIdentifier: "emptyPreviousBill")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        previousReceipts.removeAll()
        let receiptCount = UserDefaults.standard.integer(forKey: "receiptCount")
        if receiptCount > 0 {
            for index in 1...(receiptCount){
                print(index)
                if let unwrappedData = UserDefaults.standard.data(forKey: "receipts\(index)") {
                    do {
                        let items = try JSONDecoder().decode(receiptModel.self, from: unwrappedData)
                        previousReceipts.insert(items, at: 0)
                        
                    } catch let jsonErr {
                        print("error", jsonErr)
                    }
                }
            }
        }
    self.previousBillsCollectionView.reloadData()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "homeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    @IBAction func newBillButtonPressed(_ sender: Any) {
        let newBillVC = newBillViewController()
        self.navigationController?.pushViewController(newBillVC, animated: true)
    }
    
    @IBAction func previousBillsButton(_ sender: Any) {
        let previousBillsVC = previousBillsViewController()
        self.navigationController?.pushViewController(previousBillsVC, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        let settingsVC = settingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    
}

extension homeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if previousReceipts.count > 0 {
            return previousReceipts.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (previousReceipts.count == 0) {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyPreviousBill", for: indexPath) as! emptyPreviousBill
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previousBillsCollectionViewCell", for: indexPath) as! previousBillsCollectionViewCell
        let receipt = previousReceipts[indexPath.item]
        cell.receipt = receipt
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if previousReceipts.count > 0 {
            let viewBillVC = viewBillViewController()
            viewBillVC.receipt = previousReceipts[indexPath.row]
            viewBillVC.saveAvailable = false
        self.navigationController?.pushViewController(viewBillVC, animated: true)
        }
    }
}
