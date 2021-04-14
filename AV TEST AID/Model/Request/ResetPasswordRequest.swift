//
// Created by Efe Ejemudaro on 14/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct ResetPasswordRequest: Codable {

    let id: String
    let newPassword: String

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case newPassword = "password"
    }

}