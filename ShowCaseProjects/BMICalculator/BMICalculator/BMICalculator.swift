//
//  BMICalculator.swift
//  BMICalculator
//
//  Created by Shilpa Bhat on 15/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation

struct BMICalculator {
    
    var heightValue:Float = 0
    var weightValue:Float = 0
    
    func bmiValueFromImperialFormula() -> Float {
        
        if heightValue > 0 && weightValue > 0 {
           return weightValue/(heightValue * heightValue) * 703
        }
        return 0
    }
    
    func bmiValueFromMetricFormula() -> Float {
        
        if heightValue > 0 && weightValue > 0 {
            return weightValue/(heightValue * heightValue)
        }
        return 0
    }
   
}
