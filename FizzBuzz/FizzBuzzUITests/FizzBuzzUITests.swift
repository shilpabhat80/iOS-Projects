//
//  FizzBuzzUITests.swift
//  FizzBuzzUITests
//
//  Created by Shilpa Bhat on 16/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import XCTest
@testable import FizzBuzz

class FizzBuzzUITests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMove1IncrementsScore() {
        
        app.buttons["1"].tap()
        app.buttons["Play Again"].tap()
        
    
    }
}
