//
//  UserUsecase.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import RxSwift

protocol UserUsecaseInterface {
    init(interactor: UserDataInteractorInterface)
    func fetch() -> Observable<User?>
    func save(_ user: User) -> Observable<Bool>
    func deleteUser()
}

class UserUsecase: UserUsecaseInterface {
    
    private let interactor: UserDataInteractorInterface
    
    required init(interactor: UserDataInteractorInterface) {
        self.interactor = interactor
    }
    
    
    func fetch() -> Observable<User?> {
        interactor.fetch()
    }
    
    func save(_ user: User) -> Observable<Bool> {
        interactor.save(user)
    }
    
    func deleteUser() {
        interactor.deleteUser()
        UserManager.shared.setLoggedIn(status: false)
    }
    
}
