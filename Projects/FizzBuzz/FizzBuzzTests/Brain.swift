//
//  Brain.swift
//  FizzBuzz
//
//  Created by Shilpa Bhat on 16/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation

struct Brain {

    func isDivisibleBy(divisor: Int, number:Int) -> Bool {
        return (number % divisor == 0)
    }

    func check(number:Int) -> String {
        if isDivisibleBy(divisor: 3, number: number) {
            return "Fizz"
        }
        else if isDivisibleBy(divisor: 5, number: number) {
            return "Buzz"
        }
        else {
            return "FizzBuzz"
        }
    }
}
