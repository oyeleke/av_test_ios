//
// Created by Efe Ejemudaro on 15/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct OnboardUserRequest: Codable {

    let licenseNumber: String
    let nationality: String

    private enum CodingKeys: String, CodingKey {
        case licenseNumber
        case nationality
    }

}