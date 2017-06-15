//
//  CMBTeamListViewController.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 25/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit

class CMBTeamListViewController: UITableViewController {

    var teamStore: CMBTeamStore = CMBTeamStore()
    var team:[CMBPerson] = []
    dynamic var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = UIColor.pantonBlue
        readDataFromFile()
    }
    
    func readDataFromFile() {
        isLoading = true
        teamStore.readEmployeesFromFile() { employeeResults in
            self.isLoading = false
            self.team.removeAll()
            switch employeeResults {
            case let .success(employees):
                self.team.append(contentsOf: employees)
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return team.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonInfoCellId", for: indexPath) as! CMBTeamMemberTableViewCell
        
        let personInfo = team[indexPath.row]
        cell.nameLabel.text = "\(personInfo.firstName) \(personInfo.lastName)"
        cell.titleLabel.text = personInfo.title
        cell.photoView.loadImage(urlString: personInfo.avatar, withInitials: personInfo.initials)
        
        return cell
    }
    
    // MARK: segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let lastSelectionIndexPath = tableView.indexPathsForSelectedRows?.first,
            let personVC = segue.destination as? CMBPersonCollectionViewController
        {
            let person = team[lastSelectionIndexPath.row]
            personVC.person = person
            personVC.navigationItem.title = person.firstName
        }
    }
}

