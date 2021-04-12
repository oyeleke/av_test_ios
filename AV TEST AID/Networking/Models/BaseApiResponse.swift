//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

struct BaseApiResponse<T: Codable>: Codable {

    var success: Bool
    var message: String?
    var data: T?

    enum CodingKeys: String, CodingKey {
        case success, data, message
    }
}