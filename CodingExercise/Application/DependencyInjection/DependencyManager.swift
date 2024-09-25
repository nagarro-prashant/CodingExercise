//
//  DependencyManager.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RealmSwift

class DependencyManager {
    
    static func loginDI() -> LoginViewModel {
        return LoginViewModel(usecase: createUserUseCase())
    }
    
    static func postsDI() -> PostsViewModel {
        return PostsViewModel(postsUsecase: createPostsUseCase(), userUsecase: createUserUseCase())
    }
    
    static func favoritesDI() -> FavoritesViewModel {
        return FavoritesViewModel(usecase: createPostsUseCase())
    }
    
    
}

extension DependencyManager {
    
    static func createUserUseCase() -> UserUsecaseInterface {
        let repo = UserRepo(dbClient: DatabaseClient())
        let dataInteractor = UserDataInteractor(repo: repo)
        return UserUsecase(interactor: dataInteractor)
    }
    
    static func createPostsUseCase() -> PostsUsecaseInterface {
        let localRepo = PostsLocalRepo(dbClient: DatabaseClient())
        let remoteRepo = PostsRemoteRepo(client: APIClient(), url: AppEnvironment.postsUrl)
        let postsRepo = PostsRepo(remoteRepo: remoteRepo, localRepo: localRepo)
        let dataInteractor = PostsDataInteractor(remoteRepo: postsRepo)
        return PostsUsecase(dataInteractor: dataInteractor)
    }
}
