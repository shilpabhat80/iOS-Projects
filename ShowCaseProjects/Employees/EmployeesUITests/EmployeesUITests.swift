//
//  EmployeesUITests.swift
//  Employees
//
//  Created by Shilpa Bhat on 16/6/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import XCTest

class EmployeesUITests: XCTestCase {
    
    var app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAppTitle()  {
        let employeesStaticText = app.navigationBars.element(boundBy: 0).staticTexts.element(boundBy: 0)
       XCTAssertEqual(employeesStaticText.label, "Employees")
    }
}
