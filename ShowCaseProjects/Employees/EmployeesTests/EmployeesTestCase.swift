//
//  EmployeesTests.swift
//  EmployeesTests
//
//  Created by Shilpa Bhat on 11/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import XCTest

class EmployeesTests: XCTestCase {
    
    var employeeStore:EmployeeStore!
    
    override func setUp() {
        super.setUp()
        employeeStore = EmployeeStore()
    }
    
    override func tearDown() {
        employeeStore = nil
        super.tearDown()
    }
    
    func testEmployeeDetails() {
        
        let promise = expectation(description: "Employee results not fetched")
        
        employeeStore.fetchEmployees { (employeeResults) in
            switch employeeResults {
                case .success(_):
                    promise.fulfill()
                default:
                    XCTFail("Employee results not fetched")
            }
        }
        
        let result = XCTWaiter().wait(for: [promise], timeout: 1)
        XCTAssertEqual(result, .completed);
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
