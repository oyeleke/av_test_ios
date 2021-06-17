//
//  ChangePasswordRequest.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 09/05/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

struct ChangePasswordRequest: Codable {
    let old : String
    let new : String
    
    private enum CodingKeys : String, CodingKey {
        case old
        case new
    }
}
