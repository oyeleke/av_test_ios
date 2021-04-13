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
                .map { [weak self] (registerResponse: RegisterUserResponse, response: Response) in
                    SessionManager.start(session: Session(accessToken: registerResponse.tokenData.token))
                    return registerResponse.user
                }
    }

    func verifyOtp(verifyRequest: VerifyUserRequest) -> Observable<User> {
        request(for: .verifyUser(verifyRequest))
            .map {  [weak self] (user: User, response: Response) in
                return user
            }
    }

}

