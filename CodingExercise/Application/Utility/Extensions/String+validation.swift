//
//  String+validation.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//
import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
