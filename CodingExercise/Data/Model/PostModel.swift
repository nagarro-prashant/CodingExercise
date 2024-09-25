//
//  PostModel.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import RealmSwift

class PostModel: Object, Decodable {
    
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var userId: Int
    @Persisted var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case userId
    }
}


extension PostModel {
    
    func toEntity() -> Post {
        return Post(id: self.id, title: self.title, body: self.body, isFavorite: self.isFavorite)
    }
}
