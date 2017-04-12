//
//  EmployeeListViewController.swift
//  Employees
//
//  Created by Shilpa Bhat on 5/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class EmployeeListViewController: UITableViewController {
   
    var employeeStore: EmployeeStore = EmployeeStore()
    var employees:[Employee] = []
    
    @IBOutlet var employeeListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeStore.fetchEmployees() { employeeResults in
            
            self.employees.removeAll()
            switch employeeResults {
            case let .success(employees):
                    self.employees.append(contentsOf: employees)
                default:
                    break
            }
            OperationQueue.main.addOperation({ 
                self.tableView.reloadData()
            })
        }
    }
    
    // MARK: UITableViewDataSource methods
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.employees.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let employeeCell = tableView.dequeueReusableCell(withIdentifier:"EmployeeCell", for: indexPath) as! EmployeeCellView
        employeeCell.nameLabel?.text = employees[indexPath.row].name
        employeeCell.phoneLabel?.text = employees[indexPath.row].phone
        employeeCell.emailLabel?.text = employees[indexPath.row].email
        
       return employeeCell
    }
    
    // MARK: segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let lastSelectionIndexPath = employeeListTableView.indexPathsForSelectedRows?.first,
           let employeeDetailViewController = segue.destination as? EmployeeDetailViewController
        {
            let selectedEmployee = employees[lastSelectionIndexPath.row]
            employeeDetailViewController.employee = selectedEmployee
            employeeDetailViewController.navigationItem.title = selectedEmployee.name
        }
    }
}
