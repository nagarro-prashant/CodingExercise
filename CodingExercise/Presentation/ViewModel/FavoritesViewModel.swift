//
//  FavoritesViewModel.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RxSwift
import RxRelay

class FavoritesViewModel {
    
    private let usecase: PostsUsecaseInterface
    let posts = BehaviorRelay<[Post]>(value: [])
    private let bag = DisposeBag()
    
    init(usecase: PostsUsecaseInterface) {
        self.usecase = usecase
    }
    
     func fetchFavorites() {
         usecase.fetchFavorites()
            .observe(on: MainScheduler.instance)
            .bind(to: self.posts)
            .disposed(by: self.bag)
    }
    
    func deleteFavourite(_ index: Int) {
        let post = self.posts.value[index]
        let isFavorite = self.usecase.toggleFavourite(post: post)
        if isFavorite == false {
            self.fetchFavorites()
        }
   }
    
}

