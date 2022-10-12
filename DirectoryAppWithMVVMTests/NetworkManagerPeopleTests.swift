//
//  NetworkManagerTests.swift
//  DirectoryAppWithMVVMTests
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import XCTest
@testable import DirectoryAppWithMVVM

class NetworkManagerPeopleTests: XCTestCase {
    var networkManager: NetworkManager?
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.networkManager = NetworkManager(session: MockPeopleSession())
    }
    override func tearDownWithError() throws {
        self.networkManager = nil
        try super.tearDownWithError()
    }
    func testGetModelDataSuccess() {
        // Arrange
        var models: [Person] = []
        let expectation = XCTestExpectation(description: "Successfully Fetched People")
        guard let url = URL(string: "https://61e947967bc0550017bc61bf.mockapi.io/api/v1/people") else { return }
        // Act
        self.networkManager?.getModel(url: url) { (result: Result<[Person], NetworkError>) in
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
        XCTAssertEqual(models[0].firstName, "Maggie")
        XCTAssertEqual(models[0].lastName, "Brekke")
        XCTAssertEqual(models[0].email, "Crystel.Nicolas61@hotmail.com")
        XCTAssertEqual(models[0].jobtitle, "Future Functionality Strategist")
        XCTAssertEqual(models[0].favouriteColor, "pink")
    }
}
