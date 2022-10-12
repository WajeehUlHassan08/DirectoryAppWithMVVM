//
//  People.swift
//  DirectoryAppWithMVVM
//
//  Created by Wajeeh Ul Hassan on 11/10/2022.
//

import Foundation

struct Person: Codable {
    let createdAt, firstName: String
    let avatar: String
    let lastName, email, jobtitle, favouriteColor: String
    let id: String
    let data: DataClass?
    let to, fromName: String?
}

struct DataClass: Codable {
    let title, body, id, toID: String
    let fromID, meetingid: String

    enum CodingKeys: String, CodingKey {
        case title, body, id
        case toID = "toId"
        case fromID = "fromId"
        case meetingid
    }
}
