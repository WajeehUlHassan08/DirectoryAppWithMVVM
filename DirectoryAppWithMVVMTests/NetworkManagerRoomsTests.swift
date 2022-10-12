//
//  NetworkManagerRoomTests.swift
//  DirectoryAppWithMVVMTests
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import XCTest
@testable import DirectoryAppWithMVVM

class NetworkManagerRoomTests: XCTestCase {
    var networkManager: NetworkManager?
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = NetworkManager(session: MockRoomsSession())
    }
    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }
    func testGetModelDataSuccess() {
        // Arrange
        var models: [Room] = []
        let expectation = XCTestExpectation(description: "Successfully Fetched Rooms")
        guard let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/rooms") else { return }
        // Act
        self.networkManager?.getModel(url: url) { (result: Result<[Room], NetworkError>) in
            switch result {
            case .success(let page):
                models = page
                expectation.fulfill()
            case .failure:
                XCTFail("Failed Response")
            }
        }
        wait(for: [expectation], timeout: 3)
        // Assert
        XCTAssertEqual(models[0].isOccupied, false)
        XCTAssertEqual(models[0].maxOccupancy, 53539)
        XCTAssertEqual(models[0].id, "1")
    }
}
