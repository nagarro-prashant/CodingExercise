//
//  PostsRepo.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RxSwift

protocol PostsRepoInterface {
    init(remoteRepo: PostsRemoteRepoInterface, localRepo: PostsLocalRepoInterface)
    func fetch() -> Observable<[PostModel]>
    func fetchLocal() -> Observable<[PostModel]>
    func fetchFavorites() -> Observable<[PostModel]>
    func save(posts: [PostModel])
    func toggleFavourite(post: PostModel)
    func getModel(id: Int) -> PostModel?
    func deletePosts()
}

class PostsRepo: PostsRepoInterface {
    
    private let remoteRepo: PostsRemoteRepoInterface
    private let localRepo: PostsLocalRepoInterface
    
    required init(remoteRepo: PostsRemoteRepoInterface, localRepo: PostsLocalRepoInterface) {
        self.remoteRepo = remoteRepo
        self.localRepo = localRepo
    }

    func fetch() -> Observable<[PostModel]> {
        // Check for internet connectivity
        /* 
         No internet availability: fetch from remote server and save in local database
         Internet availability: fetch from local database
         */
        if Reachability.isConnectedToNetwork() {
           return self.remoteRepo.fetch()
                .observe(on: MainScheduler.instance)
                .do (onNext: { [weak self] posts in
                    self?.save(posts: posts)
                })
        } else {
           return self.localRepo.fetch()
        }
    }
    
    func fetchLocal() -> Observable<[PostModel]> {
        self.localRepo.fetch()
    }
    
    func fetchFavorites() -> Observable<[PostModel]> {
        self.localRepo.fetchFavorites()
    }
    
    func save(posts: [PostModel]) {
        self.localRepo.save(posts: posts)
    }
    
    func toggleFavourite(post: PostModel) {
        self.localRepo.toggleFavourite(post: post)
    }
    
    func getModel(id: Int) -> PostModel? {
        self.localRepo.getModel(id: id)
    }
    
    func deletePosts() {
        localRepo.deletePosts()
    }
    
    
}
