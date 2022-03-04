//
//  PhotoViewModelTests.swift
//  AssessmentTests
//
//  Created by Chamitha Wijesekera on 27/1/22.
//

import XCTest
@testable import Assessment

class PhotoViewModelTests: XCTestCase {

    var manager: ViewModelManager!
    var mockNetworkService: MockNetworkService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        manager = ViewModelManager(networkManager: mockNetworkService)
    }

    override func tearDownWithError() throws {
        manager = nil
        mockNetworkService = nil
        try super.tearDownWithError()
    }

    func test_get_photos() {
        // test if API is called when getPhotos is called
        manager.getPhotos()
        XCTAssert(mockNetworkService.isGetPhotosCalled)
    }
    
    func test_get_photos_fail() {
        // test if correct alert is shown when an error is returned
        let error = TAError.invalidResponse
        manager.getPhotos()
        mockNetworkService.getFailure(error: .invalidResponse)
        
        XCTAssertEqual(manager.alertMessage, error.rawValue)
    }
    
    func test_loading_when_fetching() {
        // given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        
        manager.animateLoadView = { [weak manager] in
            loadingStatus = manager!.isLoading
            expect.fulfill()
        }
        
        // when fetching
        manager.getPhotos()
        XCTAssertTrue(loadingStatus)
        
        // when finished fetching
        mockNetworkService!.getSuccess()
        XCTAssertFalse(loadingStatus)
        
        wait(for: [expect], timeout: 1.0)
    }
    
//    func testPhotoCount() throws {
//        let viewModel = PhotoViewModel()
//        XCTAssertTrue(viewModel.photos.count == 3)
//    }
}
