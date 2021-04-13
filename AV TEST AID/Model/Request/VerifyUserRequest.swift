//
// Created by Efe Ejemudaro on 13/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct VerifyUserRequest: Codable {

    var verificationCode: String

    private enum CodingKeys: String, CodingKey {
        case verificationCode
    }

}