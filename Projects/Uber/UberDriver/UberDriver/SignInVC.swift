//
//  SignInVC.swift
//  UberRider
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC : UIViewController {
    
    private let ShowRiderSegueIdentifier = "ShowRider"
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBAction func logIn(_ sender: UIButton) {
        
        if userName.text != "" && password.text != "" {
            AuthProvider.
        }
    }
    @IBAction func signUp(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

