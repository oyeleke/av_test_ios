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
        return String(describing: self)
    }

}

class AVTestService: BaseApiService<AVTestResource> {

    static let sharedInstance = AVTestService()

    func registerUser(user: RegisterUserRequest) -> Observable<User> {
        request(for: .register(user), at: "data")
                .map { [weak self] (registerResponse: RegisterUserResponse, response: Response) in
                    // TODO Save session Data like token
                    return registerResponse.user
                }
    }

}

