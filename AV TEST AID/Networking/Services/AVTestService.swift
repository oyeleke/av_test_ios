//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum AVTestServiceError: Error {

    case noResponse

    var localizedDescription: String {
        String(describing: self)
    }

}

class AVTestService: BaseApiService<AVTestResource> {

    static let sharedInstance = AVTestService()

    func registerUser(user: RegisterUserRequest) -> Observable<User> {
        request(for: .register(user))
            .map { (registerResponse: RegisterUserResponse, response: Response) in
                SessionManager.start(session: Session(accessToken: registerResponse.tokenData.token))
                UserDataManager.set(user: registerResponse.user)
                return registerResponse.user
            }
    }

    func verifyOtp(verifyRequest: VerifyUserRequest) -> Observable<User> {
        request(for: .verifyUser(verifyRequest))
            .map { (user: User, response: Response) in
                UserDataManager.set(user: user)
                return user
            }
    }

    func initiatePasswordReset(initiateRequest: InitiateResetPasswordRequest) -> Observable<User> {
        request(for: .initiatePasswordReset(initiateRequest))
                .map { (user: User, response: Response) in
                    UserDataManager.set(user: user)
                    return user
                }
    }

    func verifyPasswordCode(verifyRequest: VerifyPasswordCodeRequest) -> Observable<User> {
        request(for: .verifyPasswordCode(verifyRequest)).map { (user: User, response: Response) in
            UserDataManager.set(user: user)
            return user
        }
    }

    func resendPasswordCode(initiateRequest: InitiateResetPasswordRequest) -> Observable<User> {
        request(for: .resendPasswordCode(initiateRequest))
                .map { (user: User, response: Response) in
                    UserDataManager.set(user: user)
                    return user
                }
    }

    func resetPassword(resetRequest: ResetPasswordRequest) -> Observable<User> {
        request(for: .resetPassword(resetRequest))
            .map { (user: User, response: Response) in
                UserDataManager.set(user: user)
                return user
            }
    }

    func signIn(signInRequest: SignInUserRequest) -> Observable<User> {
        request(for: .signIn(signInRequest))
            .map { (user: User, response: Response) in
                UserDataManager.set(user: user)
                return user
            }
    }

}

