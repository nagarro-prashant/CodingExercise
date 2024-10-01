//
//  PostsViewModel.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 16/09/24.
//

import Foundation
import RxSwift
import RxRelay

class PostsViewModel {
    
    private let postsUsecase: PostsUsecaseInterface
    private let userUsecase: UserUsecaseInterface
    let posts = BehaviorRelay<[Post]>(value: [])
    private let bag = DisposeBag()
    
    init(postsUsecase: PostsUsecaseInterface, userUsecase: UserUsecaseInterface) {
        self.postsUsecase = postsUsecase
        self.userUsecase = userUsecase
        self.setupBindings()
    }
    
     func setupBindings() {
         postsUsecase.fetch()
             .observe(on: MainScheduler.instance)
             .do (onError: { error in
                 // Show error text
                 let errorText = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
                 print("❌ ❌ Error occured:: \(errorText)")
             })
             .subscribe(onNext: { [weak self] posts in
                 self?.posts.accept(posts)
             })
             .disposed(by: self.bag)
    }
    
    func fetchLocal() {
        postsUsecase.fetchLocal()
            .observe(on: MainScheduler.instance)
            .bind(to: self.posts)
            .disposed(by: self.bag)
    }
        
    func toggleFavourite(_ index: IndexPath) {
        let post = self.posts.value[index.row]
        let isFavorite = self.postsUsecase.toggleFavourite(post: post)
        if isFavorite != post.isFavorite {
            var posts = self.posts.value
            if let index = posts.firstIndex (where: { $0.id == post.id }) {
               posts[index].toggleFavourite()
               self.posts.accept(posts)
            }
        }
    }
    
    func logout() {
        // Remove user data from Realm
        postsUsecase.deletePosts()
        userUsecase.deleteUser()
        userUsecase.fetch()
            .observe(on: MainScheduler.instance)
            .subscribe { user in
                print("<<<<<<< User after logout >>>>>>>")
                print(user)
            }.disposed(by: bag)
    }
    
}
