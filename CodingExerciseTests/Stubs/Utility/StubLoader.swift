//
//  StubLoader.swift
//  CodingExerciseTests
//
//  Created by Prashant Gautam on 24/09/24.
//

import Foundation

import Foundation
import RxSwift

public class StubLoader {
    
    static public func load<T: Decodable>(fileName: String, type: T.Type, decoder: JSONDecoder = JSONDecoder()) -> Observable<T> {
        
        return Observable.create { observer in
            let bundle = Bundle(for: StubLoader.self)
        
            guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
                let error = NSError(domain: "Stub \(fileName) could not be found", code: 0, userInfo: nil)
                observer.onError(error)
                return Disposables.create()
            }
            do {
                let data = try Data(contentsOf: url)
                let result = try decoder.decode(type, from: data)
                
                observer.onNext(result)
                observer.onCompleted()
            } catch {
                print(error.localizedDescription)
                observer.onError(error)
            }
            // Return a disposable
            return Disposables.create()
        }
    }

}
