//
//  PostsViewRouter.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import UIKit

class PostsViewRouter {
    
    func showLoginScreen() {
        print("--- Inside showLoginScreen after logout")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController  {
            let dependencies = DependencyManager.loginDI()
            loginView.assignDependencies(viewModel: dependencies.viewModel, router: dependencies.router)
            // Set the new root view controller with an animation
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController = loginView
                window.makeKeyAndVisible()
                // Optional: Add a transition animation
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
    }
    
    deinit {
        print("💀 PostsViewRouter deinitialized")
    }
    
}
