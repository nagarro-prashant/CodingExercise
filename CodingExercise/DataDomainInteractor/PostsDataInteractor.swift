//
//  PostsDataInteractor.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RxSwift

protocol PostsDataInteractorInterface {
    func fetch() -> Observable<[Post]>
    func fetchLocal() -> Observable<[Post]>
    func fetchFavorites() -> Observable<[Post]>
    func toggleFavourite(post: Post) -> Bool
    func deletePosts()
}

class PostsDataInteractor: PostsDataInteractorInterface {
    
    private let repo: PostsRepoInterface
    
    init(remoteRepo: PostsRepoInterface) {
        self.repo = remoteRepo
    }
    
    func fetch() -> Observable<[Post]> {
        repo.fetch()
            .map { models in
                models.map { $0.toEntity() }
            }
    }
    
    func fetchLocal() -> Observable<[Post]> {
        repo.fetchLocal()
            .map { models in
                models.map { $0.toEntity() }
            }
    }
    
    func fetchFavorites() -> Observable<[Post]> {
        repo.fetchFavorites()
            .map { models in
                models.map { $0.toEntity() }
            }
    }
    
    func toggleFavourite(post: Post) -> Bool {
        guard let model = repo.getModel(id: post.id) else {
            return post.isFavorite
        }
        repo.toggleFavourite(post: model)
        return model.isFavorite
    }
    
    func deletePosts() {
        repo.deletePosts()
    }
}
