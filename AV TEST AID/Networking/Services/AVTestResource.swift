//
// Created by Efe Ejemudaro on 10/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum AVTestResource {

    case register(RegisterUserRequest)

}

extension AVTestResource: TargetType {

    public var path: String {
        switch self {
        case .register:
            return "register"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .register:
            return .post
        }
    }

    public var task: Moya.Task {
        switch self {
        case .register(let registerUserRequest):
            return .requestData(registerUserRequest.asData())
        }
    }

    // TODO do we have to set headers

}