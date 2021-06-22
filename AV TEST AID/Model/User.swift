//
//  User.swift
//  AV TEST AID
//
//  Created by Rootstrap on 1/18/17.
//  Copyright © 2017 Rootstrap. All rights reserved.
//

import Foundation

struct User: Codable {

    let id: String
    let email: String
    let isVerified: Bool
    let firstName: String
    let lastName: String
    let createdAt: String
    let profession: String?

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case isVerified = "verified"
        case firstName
        case lastName
        case createdAt
        case profession
    }
}
