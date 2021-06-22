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
    case signIn(SignInUserRequest)
    case uploadImage(Data, String)
    case fetchProfessions
    case updateProfession(String)
    case onboardUser(OnboardUserRequest)


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
        case .signIn:
            return "login"
        case .uploadImage:
            return "user/image"
        case .fetchProfessions:
            return "professions"
        case .updateProfession(let professionID):
            return "professions/\(professionID)"
        case .onboardUser:
            return "/user/onboard"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .register, .verifyUser, .initiatePasswordReset, .verifyPasswordCode, .resendPasswordCode, .resetPassword, .signIn, .uploadImage, .onboardUser:
            return .post
        case .fetchProfessions:
            return .get
        case .updateProfession:
            return .put
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
        case .signIn(let signInRequest):
            return .requestData(signInRequest.asData())
        case .uploadImage(let imageData, let imageName):
            let formData: [Moya.MultipartFormData] = [Moya.MultipartFormData(provider: .data(imageData), name: "image", fileName: imageName, mimeType: "image/jpeg")]
            return .uploadMultipart(formData)
        case .fetchProfessions, .updateProfession:
            return .requestPlain
        case .onboardUser(let onboardUserRequest):
            return .requestData(onboardUserRequest.asData())
        }
    }

    var headers: [String: String]? {
        switch self {
        case .register, .initiatePasswordReset, .verifyPasswordCode, .resendPasswordCode, .resetPassword, .signIn:
            return getBaseHeaders()
        default:
            return getHeaders()
        }
    }

}
