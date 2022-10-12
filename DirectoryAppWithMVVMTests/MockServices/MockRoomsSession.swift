//
//  MockRoomsSession.swift
//  DirectoryAppWithMVVMTests
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import Foundation
@testable import DirectoryAppWithMVVM

class MockRoomsSession: Session {
    func retrieveData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        // First Success
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            do {
                let bundle = Bundle(for: DirectoryAppWithMVVMTests.self)
                let path = bundle.path(forResource: "MockRoomsData", ofType: "json") ?? ""
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path))
                completion(jsonData, nil, nil)
            } catch {
                print(error)
                completion(nil, nil, nil)
            }
        }
    }
}
