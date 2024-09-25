//
//  LoginViewModel.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//


import RxSwift
import RxCocoa
import RealmSwift

class LoginViewModel {
    let disposeBag = DisposeBag()
    let email = BehaviorSubject<String>(value: "")
    let password = BehaviorSubject<String>(value: "")
    let isSubmitEnabled: Observable<Bool>
    let loginsubject = PublishSubject<Void>()
    
    private let usecase: UserUsecaseInterface
    
    init(usecase: UserUsecaseInterface) {
        self.usecase = usecase
        isSubmitEnabled = Observable.combineLatest(email.asObservable().map { $0.isValidEmail() },
                                                    password.asObservable().map { $0.count >= 8 && $0.count <= 15 })
            .map { $0 && $1 }
    }
 
    func login() {
        // Save user info to Realm
        let email = try! email.value()
        let password = try! password.value()
        
        self.usecase.save( User(email: email, password: password))
            .observe(on: MainScheduler.instance)
            .subscribe( onNext: { [weak self] success in
                if success {
                    // navigate to posts view
                    print("User saved successfully")
                    UserManager.shared.setLoggedIn(status: true)
                    self?.loginsubject.onNext(())
                }
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func getUser() {
        // fetch user info from Realm
        usecase.fetch()
            .observe(on: MainScheduler.instance)
            .subscribe ( onNext: { user in
                print(user)
            }).disposed(by: disposeBag)
        
    }
}
