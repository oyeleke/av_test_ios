//
//  ApiUtils.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 12/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import Moya

let sharedJsonEncoder = JSONEncoder()

extension Encodable {
    
    func asData() -> Data {
        try! sharedJsonEncoder.encode(self)
    }
    
}
