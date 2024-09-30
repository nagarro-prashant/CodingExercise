//
//  PostsRemoteRepoTests.swift
//  CodingExerciseTests
//
//  Created by Prashant Gautam on 25/09/24.
//

import XCTest
import RxSwift
import RxCocoa

@testable import CodingExercise

final class PostsRemoteRepoTests: XCTestCase {
    
    var bag: DisposeBag!
    var sut: PostsRemoteRepoInterface!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.bag = DisposeBag()
        self.sut = PostsRemoteRepo(client: APIClientMock(), url: AppEnvironment.postsUrl)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.bag = nil
    }

    func testFetchRemotePosts() throws {
        
        let modelsExpectation = expectation(description: "Expected models to be loaded")
       
        self.sut.fetch()
            .observe(on: MainScheduler.instance)
            .subscribe( onNext: { models in
                modelsExpectation.fulfill()
                print(models.count)
                XCTAssertEqual(models.count, 20, "Number of posts should be 20")
            }).disposed(by: self.bag)
        waitForExpectations(timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
