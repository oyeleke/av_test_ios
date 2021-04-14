//
// Created by Efe Ejemudaro on 10/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import Moya

enum AVTestResource {

    case register(RegisterUserRequest)
    case verifyUser(VerifyUserRequest)
    case initiatePasswordReset(InitiateResetPasswordRequest)
    case verifyPasswordCode(VerifyPasswordCodeRequest)
    case resendPasswordCode(InitiateResetPasswordRequest)
    case resetPassword(ResetPasswordRequest)

}

extension AVTestResource: TargetType {

    public var path: String {
        switch self {
        case .register:
            return "register"
        case .verifyUser:
            return "user/verify"
        case .initiatePasswordReset:
            return "user/password/reset"
        case .verifyPasswordCode:
            return "user/password/code"
        case .resendPasswordCode:
            return "user/password/resend-code"
        case .resetPassword:
            return "user/password/new"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .register, .verifyUser, .initiatePasswordReset, .verifyPasswordCode, .resendPasswordCode, .resetPassword:
            return .post
        }
    }

    public var task: Moya.Task {
        switch self {
        case .register(let registerUserRequest):
            return .requestData(registerUserRequest.asData())
        case .verifyUser(let verifyUserRequest):
            return .requestData(verifyUserRequest.asData())
        case .initiatePasswordReset(let initiatePasswordRequest):
            return .requestData(initiatePasswordRequest.asData())
        case .verifyPasswordCode(let verifyCodeRequest):
            return .requestData(verifyCodeRequest.asData())
        case .resendPasswordCode(let initiatePasswordRequest):
            return .requestData(initiatePasswordRequest.asData())
        case .resetPassword(let resetRequest):
            return .requestData(resetRequest.asData())
        }
    }

    var headers: [String: String]? {
        switch self {
        case .register, .initiatePasswordReset, .verifyPasswordCode, .resendPasswordCode, .resetPassword:
            return getBaseHeaders()
        default:
            return getHeaders()
        }
    }

}