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
    
    @IBOutlet weak var employeeListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeStore.fetchEmployees() { [weak self] employeeResults in
            
            self?.employees.removeAll()
            switch employeeResults {
            case let .success(employees):
                self?.employees.append(contentsOf: employees)
            default:
                break
            }
            OperationQueue.main.addOperation({
                self?.tableView.reloadData()
            })
        }
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


// MARK: UITableViewDataSource methods
extension EmployeeListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:"EmployeeCell", for: indexPath)
        guard let employeeCell = cell as? EmployeeCellView else { return cell }

        employeeCell.employee = employees[indexPath.row]
        return employeeCell
    }
    
}
