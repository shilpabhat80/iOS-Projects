//
//  ToDoListItemDetailViewController.swift
//  ToDoList
//
//  Created by Shilpa Bhat on 12/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class ToDoListItemDetailViewController: UIViewController {
    
    var name:String?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        name = textView.text
    }
}
