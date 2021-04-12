//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct TokenData: Codable {

    let token: String

    private enum CodingKeys: String, CodingKey {
        case token
    }

}
