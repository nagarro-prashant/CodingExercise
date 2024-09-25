//
//  UserRepoInterface.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//


import RxSwift
import RealmSwift

protocol UserRepoInterface {
    init(dbClient: DatabaseClientInterface)
    func save(user: UserModel) -> Observable<Bool>
    func getModel() -> Observable<UserModel?>
    func deleteUser()
}

class UserRepo: UserRepoInterface {
    
    private let dbClient: DatabaseClientInterface
    
    required init(dbClient: DatabaseClientInterface) {
        self.dbClient = dbClient
    }
    
    func save(user: UserModel) -> Observable<Bool> {
        do {
            try self.dbClient.realm?.write { [weak self] in
                self?.dbClient.realm?.add(user)
            }
            return .just(true)
        } catch {
            print("Realm :: User save error: \(error.localizedDescription)")
            return .error(DataPersistenceError.save).asObservable()
        }
    }
    
    
    func getModel() -> Observable<UserModel?> {
        return .just(self.dbClient.realm?.objects(UserModel.self).first)
    }
    
    func deleteUser() {
        do {
            try self.dbClient.realm?.write { [weak self] in
                // Assuming there's a User model to remove
                if let users = self?.dbClient.realm?.objects(UserModel.self) {
                    self?.dbClient.realm?.delete(users)
                    try self?.dbClient.realm?.commitWrite()
                }
            }
        } catch {
            print("Unable to delete user : \(error.localizedDescription)")
        }
    }
    
}
    
