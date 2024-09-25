//
//  LoginViewController.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//


import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    func assignDependencies(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        viewModel.isSubmitEnabled
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)

        submitButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.login()
            })
            .disposed(by: disposeBag)
        
        viewModel.loginsubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] _ in
                // Show Posts
                self?.showPosts()
            })
            .disposed(by: disposeBag)
    }
    
    func showPosts() {
        // Assuming you have a TabBarController set up in the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "PostsTabbarController") as? UITabBarController {
            tabBarController.selectedIndex = 0
            if let nav = tabBarController.viewControllers?.first as? UINavigationController, let postsView = nav.topViewController  as? PostsViewController {
                postsView.assignDependencies(viewModel: DependencyManager.postsDI())
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
        print("LoginViewController deinitialized")
    }
}
