//
//  PostsLocalRepo.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RxSwift
import RealmSwift

protocol PostsLocalRepoInterface {
    init(dbClient: DatabaseClientInterface)
    func save(posts: [PostModel])
    func fetch() -> Observable<[PostModel]>
    func fetchFavorites() -> Observable<[PostModel]>
    func toggleFavourite(post: PostModel)
    func getModel(id: Int) -> PostModel?
    func deletePosts()
}

class PostsLocalRepo: PostsLocalRepoInterface {
   
    private let dbClient: DatabaseClientInterface
    
    required init(dbClient: DatabaseClientInterface) {
        self.dbClient = dbClient
    }
    
    func save(posts: [PostModel]) {
        do {
            try self.dbClient.realm?.write { [weak self] in
                self?.dbClient.realm?.add(posts, update: .modified)
            }
        } catch {
            print("Realm :: Posts save error: \(error.localizedDescription)")
        }
    }
    
    
    func fetch() -> Observable<[PostModel]> {
        guard let objects = self.dbClient.realm?.objects(PostModel.self) else { return Observable.just([])}
        let localPosts = Array(objects)
        return Observable.just(localPosts)
    }
    
    func fetchFavorites() -> Observable<[PostModel]> {
        guard let objects = self.dbClient.realm?.objects(PostModel.self).filter("isFavorite = true") else { return Observable.just([])}
        let localPosts = Array(objects)
        return Observable.just(localPosts)
    }
    
    func toggleFavourite(post: PostModel) {
        do {
            try self.dbClient.realm?.write { [weak self] in
                post.isFavorite.toggle()
                self?.dbClient.realm?.add(post, update: .modified)
            }
        } catch {
            print("Realm :: Post favourite update error: \(error.localizedDescription)")
        }
    }
    
    func getModel(id: Int) -> PostModel? {
        return self.dbClient.realm?.object(ofType: PostModel.self, forPrimaryKey: id)
    }
    
    func deletePosts() {
        do {
            try self.dbClient.realm?.write { [weak self] in
                if let posts = self?.dbClient.realm?.objects(PostModel.self) {
                   self?.dbClient.realm?.delete(posts)
                }
            }
        } catch {
            print("Unable to delete posts : \(error.localizedDescription)")
        }
        
    }
    
}
