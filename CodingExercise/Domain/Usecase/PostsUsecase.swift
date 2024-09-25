//
//  PostsUsecase.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RxSwift

protocol PostsUsecaseInterface {
    init(dataInteractor: PostsDataInteractorInterface)
    func fetch() -> Observable<[Post]>
    func fetchLocal() -> Observable<[Post]>
    func toggleFavourite(post: Post) -> Bool
    func fetchFavorites() -> Observable<[Post]>
    func deletePosts()
}

class PostsUsecase: PostsUsecaseInterface {
    
    private let dataInteractor: PostsDataInteractorInterface
    
    required init(dataInteractor: PostsDataInteractorInterface) {
        self.dataInteractor = dataInteractor
    }
    
    func fetch() -> Observable<[Post]> {
        dataInteractor.fetch()
    }
    
    func fetchLocal() -> Observable<[Post]> {
        dataInteractor.fetchLocal()
    }
    
    func fetchFavorites() -> Observable<[Post]> {
        dataInteractor.fetchFavorites()
    }
    
    func toggleFavourite(post: Post) -> Bool {
        dataInteractor.toggleFavourite(post: post)
    }
    
    func deletePosts() {
        dataInteractor.deletePosts()
    }
}
