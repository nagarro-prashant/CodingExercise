//
//  APIClientMock.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 25/09/24.
//

import Foundation
import RxSwift

class APIClientMock: APIClientInterface {
    
    func request<T>(url: String, type: T.Type, decoder: JSONDecoder) -> Observable<T> where T : Decodable {
        guard let _ = URL(string: url) else { return .error(NetworkError.badUrl) }
        return StubLoader.load(fileName: "Posts", type: type)
    }
    
}
