//
//  ViewController.swift
//  AsymmetricCryptoDemo
//
//  Created by Moideen Nazaif VM on 27/06/20.
//  Copyright © 2020 Moideen Nazaif VM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        encryptDecrypt()
    }

    private func encryptDecrypt() {
        let facade = KeychainFacade()
        let text = "superSECRETText"
        do {
            if let encryptedData = try facade.encrypt(text: text) {
                print("Text encryption successfull")
                if let decryptedData = try facade.decrypt(data: encryptedData) {
                    print("Data decrypted successfully")
                    print(String(data: decryptedData, encoding: .utf8) ?? "")
                }
            }
        } catch {
            print(error)
        }
    }
    
}

