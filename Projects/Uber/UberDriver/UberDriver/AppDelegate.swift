//
//  AppDelegate.swift
//  UberDriver
//
//  Created by Shilpa Bhat on 1/7/17.
//  Copyright © 2017 Shilpa Bhat. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        return true
    }
}

