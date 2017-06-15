//
//  ViewController.swift
//  EmployeesMacOS
//
//  Created by Shilpa Bhat on 29/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var employeeStore: EmployeeStore = EmployeeStore()
    dynamic var employees:[Employee] = []
    dynamic var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readDataFromServer()
    }

    
    func readDataFromFile() {
        isLoading = true
        employeeStore.readEmployeesFromFile() { employeeResults in
            self.isLoading = false
            self.employees.removeAll()
            switch employeeResults {
            case let .success(employees):
                self.employees.append(contentsOf: employees)
            default:
                break
            }
        }
    }

    func readDataFromServer() {
        employeeStore.fetchEmployees() { employeeResults in
            
            self.employees.removeAll()
            switch employeeResults {
            case let .success(employees):
                self.employees.append(contentsOf: employees)
            default:
                break
            }
        }
    }

}

