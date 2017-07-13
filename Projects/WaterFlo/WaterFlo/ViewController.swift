//
//  ViewController.swift
//  WaterFlo
//
//  Created by Shilpa Bhat on 25/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addGlassButton: PushButtonView!
    @IBOutlet weak var removeGlassButton: PushButtonView!
    
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!

    @IBOutlet weak var counterLabel: UILabel!
    
    var counter = 0 {
        didSet {
            counterView.counter = counter
            counterLabel.text = String(counter)
            
            addGlassButton.isEnabled = counter < numberOfGlasses
            removeGlassButton.isEnabled = counter > 0
        }
    }
    
    var isGraphViewShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addGlass(_ sender: PushButtonView) {
        counter += 1
    }
    
    @IBAction func removeGlass(_ sender: PushButtonView) {
        counter -= 1
    }
    
 
    @IBAction func counterViewTap(gesture:UITapGestureRecognizer?) {
        if (isGraphViewShowing) {
            
            //hide Graph
            let options = UIViewAnimationOptions.transitionFlipFromLeft.union(.showHideTransitionViews)

            UIView.transition(from: graphView, to: counterView, duration: 1.0, options: options, completion: nil)
        } else {
            
            //show Graph
            let options = UIViewAnimationOptions.transitionFlipFromRight.union(.showHideTransitionViews)
            UIView.transition(from: counterView, to: graphView, duration: 1.0, options: options, completion: nil)

        }
        isGraphViewShowing = !isGraphViewShowing
    }

}

