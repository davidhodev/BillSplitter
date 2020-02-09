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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        previousBillsCollectionView.delegate = self
        previousBillsCollectionView.dataSource = self
        previousBillsCollectionView.isUserInteractionEnabled = true
        previousBillsCollectionView.register(UINib(nibName: "previousBillsCollectionViewCell", bundle:nil), forCellWithReuseIdentifier: "previousBillsCollectionViewCell")
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
    
}

extension homeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        previousBills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previousBillsCollectionViewCell", for: indexPath) as! previousBillsCollectionViewCell
        let bill = previousBills[indexPath.item]
        cell.bill = bill
        return cell
    }
    
}