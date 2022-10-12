//
//  Room.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import Foundation

struct Room: Codable {
    let createdAt: String
    let isOccupied: Bool
    let maxOccupancy: Int
    let id: String
}
