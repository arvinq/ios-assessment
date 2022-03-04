//
//  MockNetworkService.swift
//  AssessmentTests
//
//  Created by Arvin Quiliza on 4/3/22.
//

import UIKit
@testable import Assessment

class MockNetworkService: NetworkManagerProtocol {
    
    var isGetPhotosCalled = false
    
    var photos: [Photo] = [Photo]()
    var completion: ((Result<[Photo], TAError>) -> ())!
    
    func getPhotos(completion: @escaping (Result<[Photo], TAError>) -> Void) {
        isGetPhotosCalled = true
        self.completion = completion
    }
    
    func getSuccess() {
        self.completion(.success(photos))
    }
    
    func getFailure(error: TAError) {
        self.completion(.failure(error))
    }
}
