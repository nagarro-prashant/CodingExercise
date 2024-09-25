//
//  UserDataInteractor.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import RxSwift

protocol UserDataInteractorInterface {
    func fetch() -> Observable<User?>
    func save(_ user: User) -> Observable<Bool>
    func deleteUser()
}

class UserDataInteractor: UserDataInteractorInterface {
    
    private let repo: UserRepoInterface
    
    init(repo: UserRepoInterface) {
        self.repo = repo
    }
    
    func fetch() -> Observable<User?> {
        repo.getModel().map {
            if $0 != nil {
                return User(email: $0?.email ?? "", password: $0?.password ?? "")
            } else {
                return nil
            }
        }
    }
    
    func save(_ user: User) -> Observable<Bool> {
        let model = UserModel()
        model.email = user.email
        model.password = user.password
        return self.repo.save(user: model)
    }
    
    func deleteUser() {
        repo.deleteUser()
    }
}
