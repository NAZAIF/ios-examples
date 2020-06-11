//
//  ViewController.swift
//  Invoker App
//
//  Created by jerin on 11/06/20.
//  Copyright © 2020 nazaif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickCallListener(_ sender: Any) {
        guard let listenerAppUrl = URL(string: "listenerapp://"), UIApplication.shared.canOpenURL(listenerAppUrl) else {
            print("Could not form URL to Listener App")
            return
        }
        UIApplication.shared.open(listenerAppUrl, options: [:]) { (success) in
            if success == false {
                print("Could not open URL \(listenerAppUrl.absoluteString)")
            }
        }
        
    }
    
}

