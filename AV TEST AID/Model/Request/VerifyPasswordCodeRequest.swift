//
// Created by Efe Ejemudaro on 14/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct VerifyPasswordCodeRequest: Codable {

    var email: String
    var verificationCode: String

    private enum CodingKeys: String, CodingKey {
        case email
        case verificationCode = "code"
    }

}