//
//  ViewController.swift
//  Pasteboard
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    lazy var keychain = KeychainFacade()
    
    @IBAction func onSaveCredentials(_ sender: Any) {
        if let username = usernameField.text,
            let password = passwordField.text {
            do {
                try keychain.set(string: username, forKey: "userName")
                try keychain.set(string: password, forKey: "password")
            } catch let facadeError as KeychainFacadeError {
                print("Could not store credentials in keychain. \(facadeError)")
            } catch {
                print(error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let username = try? keychain.string(forKey: "userName"), let password = try? keychain.string(forKey: "password") else {
            print("Could not retrieve credentials from Keychain")
            return
        }
        usernameField.text = username
        passwordField.text = password
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

