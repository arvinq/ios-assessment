//
//  NetworkTest.swift
//  AssessmentTests
//
//  Created by Arvin Quiliza on 4/3/22.
//

import XCTest
@testable import Assessment

class NetworkTest: XCTestCase {
    var manager: NetworkManager?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        manager = NetworkManager()
    }

    override func tearDownWithError() throws {
        manager = nil
        try super.tearDownWithError()
    }

    func test_get_photos() {
        let manager = self.manager!
        let expect = XCTestExpectation(description: "callback")
        
        manager.getPhotos { result in
            expect.fulfill()
            
            switch result {
            case .success(let photos):
                // test if there's an author and download url for image
                let _ = photos.map {
                    XCTAssertNotNil($0.author)
                    XCTAssertNotNil($0.downloadUrl)
                }
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }

    func test_cell_view_model() {
        let manager = self.manager!
        let expect = XCTestExpectation(description: "callback")
        
        manager.getPhotos { result in
            expect.fulfill()
            
            switch result {
            case .success(let photos):
                let photoViewModelList = photos.map {
                    PhotoViewModel(photo: $0)
                }
                
                // Picking a random photo, assert the correctness of cell display information
                XCTAssertEqual(photos[0].author, photoViewModelList[0].author)
                XCTAssertEqual(photos[0].downloadUrl, photoViewModelList[0].downloadUrl)
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
}
