//
//  UserManager.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//
import Foundation

class UserManager {
    
    struct Constants {
        static let isLoggedInUser = "isLoggedInUser"
    }
    
    static let shared = UserManager()
    private init () {}
    
    var isLoggedInUser: Bool {
        UserDefaults.standard.bool(forKey: Constants.isLoggedInUser)
    }
    
    func setLoggedIn(status: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(status, forKey: Constants.isLoggedInUser)
    }
}
