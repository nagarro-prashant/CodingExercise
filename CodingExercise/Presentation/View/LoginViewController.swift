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
    private var router: LoginViewRouter!
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    func assignDependencies(viewModel: LoginViewModel, router: LoginViewRouter) {
        self.viewModel = viewModel
        self.router = router
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
                self?.router.showPosts()
            })
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("💀 LoginViewController deinitialized")
    }
}
