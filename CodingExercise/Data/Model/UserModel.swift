//
//  UserModel.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import RealmSwift

class UserModel: Object {
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
}
