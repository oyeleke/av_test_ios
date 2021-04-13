//
// Created by Efe Ejemudaro on 10/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum AVTestResource {

    case register(RegisterUserRequest)
    case verifyUser(VerifyUserRequest)

}

extension AVTestResource: TargetType {

    public var path: String {
        switch self {
        case .register:
            return "register"
        case .verifyUser:
            return "user/verify"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .register, .verifyUser:
            return .post
        }
    }

    public var task: Moya.Task {
        switch self {
        case .register(let registerUserRequest):
            return .requestData(registerUserRequest.asData())
        case .verifyUser(let verifyUserRequest):
            return .requestData(verifyUserRequest.asData())
        }
    }

    var headers: [String: String]? {
        switch self {
        case .register:
            return getBaseHeaders()
        default:
            return getHeaders()
        }
    }

}