//
//  SceneDelegate.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 23/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        if UserManager.shared.isLoggedInUser {
            showTabBarController(with: scene)
        } else {
            showLoginScreen(with: scene)
        }
    }
    
    func showTabBarController(with scene: UIWindowScene) {
        print("--- Inside showTabBarController ")
        // Assuming you have a TabBarController set up in the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "PostsTabbarController") as? UITabBarController  {
            tabBarController.selectedIndex = 0
            if let nav = tabBarController.viewControllers?.first as? UINavigationController, let postsView = nav.topViewController  as? PostsViewController {
                print("posts NAv")
                postsView.assignDependencies(viewModel: DependencyManager.postsDI())
            }
            if let nav = tabBarController.viewControllers?.last as? UINavigationController, let favView = nav.topViewController  as? FavoritesViewController {
                print(" fav NAv")
                favView.assignDependencies(viewModel: DependencyManager.favoritesDI())
            }
            self.window?.rootViewController = tabBarController
            self.window?.makeKeyAndVisible()
        }
    }
    
    func showLoginScreen(with scene: UIWindowScene) {
        print("--- Inside showLoginScreen ")
        // Assuming you have a TabBarController set up in the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginView = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController  {
            loginView.assignDependencies(viewModel: DependencyManager.loginDI())
            self.window?.rootViewController = loginView
            self.window?.makeKeyAndVisible()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

