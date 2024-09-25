//
//  LoginViewRouter.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import UIKit

class LoginViewRouter {
    
    func showPosts() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "PostsTabbarController") as? UITabBarController {
            tabBarController.selectedIndex = 0
            if let nav = tabBarController.viewControllers?.first as? UINavigationController, let postsView = nav.topViewController  as? PostsViewController {
                postsView.assignDependencies(viewModel: DependencyManager.postsDI(), router: PostsViewRouter())
            }
            if let nav = tabBarController.viewControllers?.last as? UINavigationController, let favView = nav.topViewController  as? FavoritesViewController {
                favView.assignDependencies(viewModel: DependencyManager.favoritesDI())
            }
            // Set the new root view controller with an animation
            if let window = UIApplication.shared.keyWindow {
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
                // Optional: Add a transition animation
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
        }
    }
    
    deinit {
        print("💀💀💀💀 LoginViewRouter deinitialized")
    }
    
}
