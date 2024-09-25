//
//  PostsRemoteRepo.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RxSwift
import RealmSwift

protocol PostsRemoteRepoInterface {
    init(client: APIClientInterface, url: String)
    func fetch() -> Observable<[PostModel]>
}

class PostsRemoteRepo: PostsRemoteRepoInterface {
    
    private let client: APIClientInterface
    private let url: String
    
    required init(client: APIClientInterface, url: String) {
        self.client = client
        self.url = url
    }
    
    func fetch() -> Observable<[PostModel]> {
        return self.client.request(url: self.url, type: [PostModel].self, decoder: JSONDecoder())
   }
   
}
