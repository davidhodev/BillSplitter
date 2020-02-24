//
//  newBillViewController.swift
//  BillSplitter
//
//  Created by David Ho on 2/9/20.
//  Copyright © 2020 David Ho. All rights reserved.
//

import UIKit
import TesseractOCR

class newBillViewController: UIViewController, G8TesseractDelegate {
    @IBOutlet weak var label: UILabel!
    
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
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }
    
    
}

