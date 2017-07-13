//
//  SignInVC.swift
//  Uber app for Driver
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import Firebase

class SignInVC : UIViewController {
    
    private let ShowDriverSegueIdentifier = "ShowDriver"
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func logIn(_ sender: UIButton) {
        
        if userName.text != "" && password.text != "" {
            AuthProvider.shared.login(withEmail: userName.text!, password: password.text!, loginHandler: { [weak self](message) in
                
                if  let msg = message {
                    self?.alertTheUser(title: "Error", message: msg)
                } else {
                    print("Login successful.")
                }
            })
        }
    }
    @IBAction func signUp(_ sender: UIButton) {
//        if userName.text != "" && password.text != "" {
//            AuthProvider.shared.login(withEmail: userName.text!, password: password.text!, loginHandler: { (message) in
//                print(message)
//            })
//        }

    }
    
    private func alertTheUser(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

