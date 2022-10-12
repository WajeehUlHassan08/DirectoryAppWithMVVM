//
//  Session.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import Foundation

protocol Session {
    func retrieveData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}
extension URLSession: Session {
    func retrieveData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }.resume()
    }
}
