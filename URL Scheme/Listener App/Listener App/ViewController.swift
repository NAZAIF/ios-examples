//
//  ViewController.swift
//  Listener App
//
//  Created by jerin on 11/06/20.
//  Copyright © 2020 nazaif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "MEssageReceived"), object: nil, queue: OperationQueue.main) { (notification) in
            if let message = notification.object as? String {
                self.label.text = message.removingPercentEncoding
            }
        }
        // Do any additional setup after loading the view.
    }


}

