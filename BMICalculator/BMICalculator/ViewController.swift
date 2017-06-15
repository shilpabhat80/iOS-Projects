//
//  ViewController.swift
//  BMICalculator
//
//  Created by Shilpa Bhat on 15/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var bmiCalci = BMICalculator()
    
    var bmiFormulaType: Int = 0 {
        didSet {
            updateViewBasedOnFormulaType()
        }
    }
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var heightInFeetTextField: UITextField!
    @IBOutlet weak var heightInInchesTextField: UITextField!
    @IBOutlet weak var weightInPoundTextField: UITextField!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var metricHeightStackView: UIStackView!
    @IBOutlet weak var imperialHeightStackView: UIStackView!
    @IBOutlet weak var metricWeightStackView: UIStackView!
    @IBOutlet weak var imperialWeightStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bmiFormulaType = 0
    }
    
    func updateViewBasedOnFormulaType() {
        
        let hideMetricType = (bmiFormulaType == 0)
        metricHeightStackView.isHidden = hideMetricType
        metricWeightStackView.isHidden = hideMetricType
        
        imperialHeightStackView.isHidden = !hideMetricType
        imperialWeightStackView.isHidden = !hideMetricType
    }
    
    
    @IBAction func formulaTypeChanged(_ sender: UISegmentedControl) {
        bmiFormulaType = sender.selectedSegmentIndex
    }
    
    @IBAction func calculate(_ sender: Any) {
        
        if bmiFormulaType == 1 {
            if let heightValue = heightTextField.text,
                let weightValue = weightTextField.text,
                let height = Float(heightValue),
                let weight = Float(weightValue)
                
            {
                
                bmiCalci.heightValue = height/100.0
                bmiCalci.weightValue = weight
            }
        }
        else
        {
            if let feetValue = heightInFeetTextField.text,
                let inchesValue = heightInInchesTextField.text,
                let weightValue = weightInPoundTextField.text,
                let feet = Float(feetValue),
                let inches = Float(inchesValue),
                let weight = Float(weightValue)
            {
                
                bmiCalci.heightValue = feet * 12 + inches
                bmiCalci.weightValue = weight
            }
        }
        let bmiValue = (bmiFormulaType == 0) ? bmiCalci.bmiValueFromImperialFormula() : bmiCalci.bmiValueFromMetricFormula()
        bmiLabel.text = String(bmiValue)
        
    }
}

