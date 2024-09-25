//
//  DependencyManager.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RealmSwift

class DependencyManager {
    
    private init() {}
    
    static func loginDI() -> LoginDependencyManager {
        let viewModel = LoginViewModel(usecase: createUserUseCase())
        return LoginDependencyManager(viewModel: viewModel, router: LoginViewRouter())
    }
    
    static func postsDI() -> PostsDependencyManager {
        let viewModel = PostsViewModel(postsUsecase: createPostsUseCase(), userUsecase: createUserUseCase())
        return PostsDependencyManager(viewModel: viewModel, router: PostsViewRouter())
    }
    
    static func favoritesDI() -> FavoritesDependencyManager {
        let viewModel = FavoritesViewModel(usecase: createPostsUseCase())
        return FavoritesDependencyManager(viewModel: viewModel)
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

class LoginDependencyManager {
    let viewModel: LoginViewModel!
    let router: LoginViewRouter!
    
    init(viewModel: LoginViewModel, router: LoginViewRouter) {
        self.viewModel = viewModel
        self.router = router
    }
}

class PostsDependencyManager {
    let viewModel: PostsViewModel!
    let router: PostsViewRouter!
    
    init(viewModel: PostsViewModel, router: PostsViewRouter) {
        self.viewModel = viewModel
        self.router = router
    }
}

class FavoritesDependencyManager {
    let viewModel: FavoritesViewModel!
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
}
