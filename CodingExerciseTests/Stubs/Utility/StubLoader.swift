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
        
        let stubSubject = ReplaySubject<T>.create(bufferSize: 2)
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            let bundle = Bundle(for: StubLoader.self)
        
            guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
                let error = NSError(domain: "Stub \(fileName) could not be found", code: 0, userInfo: nil)
                stubSubject.onError(error)
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let result = try decoder.decode(type, from: data)
                
                stubSubject.onNext(result)
                stubSubject.onCompleted()
            } catch {
                print(error.localizedDescription)
                stubSubject.onError(error)
            }
            
        }
        
        return stubSubject
    }

}
