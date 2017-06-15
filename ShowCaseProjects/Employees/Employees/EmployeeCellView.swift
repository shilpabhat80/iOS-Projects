//
//  EmployeeCellView.swift
//  Employees
//
//  Created by Shilpa Bhat on 11/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class EmployeeCellView : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var employee:Employee? {
        didSet {
            
            guard let employee =  employee else { return }

            nameLabel?.text = employee.name
            phoneLabel?.text = employee.phone
            emailLabel?.text = employee.email
        }
    }
    
}
