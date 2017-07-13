//
//  ViewController.swift
//  CoreTextMagazine
//
//  Created by Shilpa Bhat on 25/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ctView: CTView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        guard let file = Bundle.main.path(forResource: "zombies", ofType: "txt") else { return }
        
        do {
            let text = try String(contentsOfFile: file, encoding: .utf8)
            // 2
            let parser = MarkupParser()
            parser.parseMarkup(text)
            ctView.importAttrString(parser.attrString)
        } catch _ {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

