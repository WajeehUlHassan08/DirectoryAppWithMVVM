//
//  ImageCache.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import Foundation

class ImageCache {
    static let shared = ImageCache()
    private let cache: NSCache<NSString, NSData>
    init() {
        self.cache = NSCache<NSString, NSData>()
    }
}

extension ImageCache {
    func setImageData(data: Data, key: String) {
        let nsKey = NSString(string: key)
        let object = NSData(data: data)
        self.cache.setObject(object, forKey: nsKey)
    }
    func getImageData(key: String) -> Data? {
        let nsKey = NSString(string: key)
        guard let object = self.cache.object(forKey: nsKey) else { return nil }
        return Data(referencing: object)
    }
}
