//
//  EmployeeDetailViewController.swift
//  Employees
//
//  Created by Shilpa Bhat on 11/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    var employee:Employee?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var empImageView: UIImageView!
    @IBOutlet weak var customNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!

    func updateEmployeeInfo() {
        self.nameLabel.text = employee?.name
        self.emailLabel.text = employee?.email
        self.phoneLabel.text = employee?.phone
        self.customNameLabel.text = employee?.username
        self.idLabel.text = employee?.id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        updateEmployeeInfo()
    }
}
