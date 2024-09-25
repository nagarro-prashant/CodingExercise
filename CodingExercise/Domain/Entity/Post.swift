//
//  Post.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation

struct Post: Codable {
    
    let id: Int
    let title: String
    let body: String
    var isFavorite: Bool = false
    
    mutating func toggleFavourite() {
        self.isFavorite.toggle()
    }
}
