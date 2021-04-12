//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation

enum Result<T> {

    case Success(T) //Data
    case Error(String, String) //ErrorMessage, ErrorCode

    func toString() -> String {
        switch self {
        case .Success(let data):
            return "Success is \(data)"
        case .Error(let errorMessage, let errorCode):
            return "Error[\(errorCode): \(errorMessage)]"
        }
    }
}