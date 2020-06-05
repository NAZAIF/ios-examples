//
//  ViewController.swift
//  App Startup
//
//  Created by jerin on 04/06/20.
//  Copyright © 2020 jerin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
        
        if textView.isFirstResponder {
            coder.encode(textView.text, forKey: "EditedText")
        }
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        super.decodeRestorableState(with: coder)
        
        if let editedText = coder.decodeObject(forKey: "EditedText") as? String {
            textView.text = editedText
        }
    }

}

