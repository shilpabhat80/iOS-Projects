//
//  AuthProvider.swift
//  UberRider
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import Foundation
import Firebase

typealias LoginHandler = (_ msg:String?) -> Void

internal class AuthProvider {
    
    private static let instance = AuthProvider()
    
    static var shared:AuthProvider  {
        return instance
    }
    
    func login(withEmail email:String, password: String, loginHandler: LoginHandler?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErros(err: error! as NSError, loginHandler: loginHandler)
            }
            else {
                
            }
        })
    }
    
    private func handleErros(err: NSError, loginHandler: LoginHandler?) {
        
        if let errorCode = FIRAuthErrorCode(rawValue: err.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                loginHandler!("Please enter valid email address.")
            default:
                loginHandler!("Please correct user name or password.")
            }
        }
    }
}
