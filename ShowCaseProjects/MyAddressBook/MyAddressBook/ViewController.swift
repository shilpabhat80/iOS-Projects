//
//  ViewController.swift
//  MyAddressBook
//
//  Created by Shilpa Bhat on 7/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class ViewController: UIViewController , CNContactPickerDelegate {
    
    @IBAction func addMe(_ sender: Any) {
        
        let personPicker = CNContactPickerViewController()
        personPicker.delegate = self
        present(personPicker, animated: true, completion: nil)
    }

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var phoneNumbr: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
//        dismiss(animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
//    }

    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.firstName.text = contact.givenName
    }
}

