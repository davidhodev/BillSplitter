//
//  newBillViewController.swift
//  BillSplitter
//
//  Created by David Ho on 2/9/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import UIKit
import TesseractOCR

class newBillViewController: UIViewController, G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, addItemDelegate {
    
    
    @IBOutlet weak var noItemsImage: UIImageView!
    @IBOutlet weak var noItemsLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var itemsTableView: UITableView!
    var receipt: receiptModel?
    var delegate: addItemDelegate?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "newBillViewController", bundle: nil)
    }
       
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = UIImage(named: "demoReceipt")
            tesseract.setVariableValue("0123456789", forKey: "tessedit_char_whitelist")
//            tesseract.pageSegmentationMode = .auto
            tesseract.recognize()
            label.text = tesseract.recognizedText
            label.isHidden = true
        }
        self.itemsTableView.delegate = self
        self.itemsTableView.dataSource = self
        self.itemsTableView.backgroundColor = UIColor(red:0.95, green:0.92, blue:0.98, alpha:1.0)
        
        if receipt == nil {
            receipt = receiptModel()
            itemsTableView.isHidden = true
            noItemsImage.isHidden = false
            noItemsLabel.isHidden = false
        }
        self.delegate = self
        
        itemsTableView.register(UINib(nibName: "itemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemTableViewCell")
        itemsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }
    
    @IBAction func openCameraPressed(_ sender: Any) {
        let cameraVC = UIImagePickerController()
        cameraVC.sourceType = .camera
        cameraVC.allowsEditing = true
        cameraVC.delegate = self
        self.present(cameraVC, animated: true)
    }
    
    @IBAction func addItemButtonPressed(_ sender: Any) {
        let vc = addItemView()
        vc.delegate = self
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let receiptItemsCount = receipt?.getItems().count {
            return receiptItemsCount
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell", for: indexPath) as! itemTableViewCell
        cell.item = receipt?.getItems()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.itemsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.receipt?.deleteItem(index: indexPath.row)
            self.itemsTableView.reloadData()
        }
        if self.receipt?.getItems().count == 0 {
            itemsTableView.isHidden = true
            noItemsImage.isHidden = false
            noItemsLabel.isHidden = false
        }
    }
    
    func addItem(name: String, price: Double) {
        self.receipt?.addItem(name: name, price: price)
        self.itemsTableView.reloadData()
        itemsTableView.isHidden = false
        noItemsImage.isHidden = true
        noItemsLabel.isHidden = true
    }
    
}



