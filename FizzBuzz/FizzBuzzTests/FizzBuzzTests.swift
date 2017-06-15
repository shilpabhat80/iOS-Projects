//
//  FizzBuzzTests.swift
//  FizzBuzzTests
//
//  Created by Shilpa Bhat on 16/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import XCTest
@testable import FizzBuzz

class FizzBuzzTests: XCTestCase {
    
    let brain = Brain()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testIsDivibleByThree() {
        let result = brain.isDivisibleBy(divisor:3, number:6)
        XCTAssertEqual(result, true)
    }
    
    func testIsDivibleByFive() {
        let result = brain.isDivisibleBy(divisor:5, number:10)
        XCTAssertEqual(result, true)
    }
    
    func testIsDivibleByThreeAndFive() {
        let result = brain.isDivisibleBy(divisor:15, number:30)
        XCTAssertEqual(result, true)
    }
    
    func testSayFizz() {
        let result = brain.check(number:3)
        XCTAssertEqual(result, "Fizz")
    }
    
    func testSayBuzz() {
        let result = brain.check(number:10)
        XCTAssertEqual(result, "Buzz")
    }
    
    func testSayFizzBuzz() {
        let result = brain.check(number:11)
        XCTAssertEqual(result, "FizzBuzz")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

