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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        let label = UILabel(frame: view.frame);
        label.text = "test";
        label.backgroundColor = UIColor.white;
        view.addSubview(label);
        
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = UIImage(named: "demoReceipt")
            tesseract.recognize()
            label.text = tesseract.recognizedText
        }
    }
    
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress) %")
    }
    
    
}

