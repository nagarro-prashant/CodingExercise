//
//  APIClient.swift
//  CodingExercise
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation
import Alamofire
import RxSwift

protocol APIClientInterface {
    
    func request<T: Decodable>(url:String, type: T.Type, decoder: JSONDecoder) -> Observable<T>
}

public class APIClient: APIClientInterface {
    
    func request<T:Decodable>(url:String, type: T.Type, decoder: JSONDecoder) -> Observable<T> {
        
        guard let url = URL(string: url) else { return .error(NetworkError.badUrl) }
        
        var request = URLRequest(url: url)
        request.addValue("no-store", forHTTPHeaderField: "Cache-Control")
        
        return Observable.create { observer in
            AF.request(request)
                .validate() // Validate the response ensures the response status code is within the acceptable range (200-299).
                .responseDecodable(of: type.self) { response in
                    switch response.result {
                    case .success(let result):
                        observer.onNext(result)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(NetworkError(statusCode: error.responseCode ?? -1))
                    }
                }
            // Return a disposable
            return Disposables.create()
        }
        
    }
}
