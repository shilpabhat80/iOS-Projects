//
//  EmployeeStore.swift
//  Employees
//
//  Created by Shilpa Bhat on 29/4/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation

enum SerializationError: Error {
    case noJSONData
    case failureForJSONConv
    case invalidURL(String)
    case missing(String)
    case invalid(String, Any)
}

// MARK: Request [Handler]

struct EmployeeRequestHandler
{
    static func fetchEmployeeListURL() -> URL? {
        return URL(string: "http://www.mocky.io/v2/58e561ee1100000f08bfc571")
    }
}

// MARK: Response [Handler]

enum FetchEmployeeResults {
    case success([Employee])
    case failure(Error)
}

struct EmployeeResponseHandler {
    
    static func processEmployeeResults(data:Data?, error:Error?) -> FetchEmployeeResults {
        
        guard error == nil else {
            return FetchEmployeeResults.failure(error!)
        }
        guard let usableData = data else {
            return FetchEmployeeResults.failure(SerializationError.noJSONData)
        }
        guard let json = try? JSONSerialization.jsonObject(with: usableData, options: []) as? [String: Any] else {
            return FetchEmployeeResults.failure(SerializationError.failureForJSONConv)
        }
        guard let fetchedEmployees = json?["employees"] as? [Any] else {
            return FetchEmployeeResults.failure(SerializationError.missing("employees"))
        }
        var employees:[Employee] = []
        for case let result in fetchedEmployees {
            if let employee = Employee(json:result as! [String:Any]) {
                employees.append(employee)
            }
        }
        return FetchEmployeeResults.success(employees)
    }
}

// MARK:
struct EmployeeStore {
    
    private let session = URLSession.shared
    
    func fetchEmployees(completion: @escaping (FetchEmployeeResults) -> Void) {
        
        guard let fetchEmployeeListURL = EmployeeRequestHandler.fetchEmployeeListURL() else {
            return
        }
        
        let task = session.dataTask(with: fetchEmployeeListURL, completionHandler: {
            (data, response, error) in
            
            let employeeResults = EmployeeResponseHandler.processEmployeeResults(data: data, error: error)
            
            completion(employeeResults)
        })
        task.resume()
    }
}
