//
// Created by Efe Ejemudaro on 14/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct SignInUserResponse: Codable {

    let tokenData: TokenData
    let user: User

    private enum CodingKeys: String, CodingKey {
        case tokenData
        case user = "profile"
    }

}