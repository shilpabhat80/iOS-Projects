//
//  TeamStore.swift
//  CMBTeam
//
//  Created by Shilpa Bhat on 25/5/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation
import SwiftyJSON

enum CMBSerializationError: Error {
    case noJSONData
    case failureForJSONConv
    case invalidURL(String)
    case missing(String)
    case invalid(String, Any)
}

enum CMBFetchTeamResults {
    case success([CMBPerson])
    case failure(Error)
}

// MARK:
class CMBTeamStore {
    
    private let session = URLSession.shared
    
    func readEmployeesFromFile(completion: @escaping (CMBFetchTeamResults) -> Void) {
        
        guard let filePath = Bundle.main.path(forResource: "team", ofType: "json") else {
                return
        }
        let sourceFileURL = URL(fileURLWithPath:filePath)

        let fileData = try? Data.init(contentsOf: sourceFileURL, options: [])
                
        let employeeResults = processResults(data: fileData, error: nil)
        
        completion(employeeResults)
    }
    
    func processResults(data:Data?, error:Error?) -> CMBFetchTeamResults {
        
        guard error == nil else {
            return CMBFetchTeamResults.failure(error!)
        }
        guard let usableData = data else {
            return CMBFetchTeamResults.failure(CMBSerializationError.noJSONData)
        }
        
        var employees:[CMBPerson] = []

        let useSwiftyJSON = true
        if (useSwiftyJSON) {
            let employeesResults = JSON(usableData)
            for result in employeesResults.arrayValue {
                if let employee = try? CMBPerson(json:result) {
                    employees.append(employee!)
                }
            }
        }
        else {
            guard let fetchedEmployees = try? JSONSerialization.jsonObject(with: usableData, options: []) as? [Any] else {
                return CMBFetchTeamResults.failure(CMBSerializationError.failureForJSONConv)
            }
            for case let result in fetchedEmployees! {
                if let employee = try? CMBPerson(json:result as! [String:Any]) {
                    employees.append(employee!)
                }
            }
        }
        
       return CMBFetchTeamResults.success(employees)
    }

}
