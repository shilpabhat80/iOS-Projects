//
//  ViewController.swift
//  FizzBuzz
//
//  Created by Shilpa Bhat on 16/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let game = Game()
    var gameScore:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func play(move: String) {
        game.score = Int(move)!
        gameScore = game.score
    }
}

