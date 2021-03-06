//
//  UserService.swift
//  AV TEST AID
//
//  Created by Mauricio Cousillas on 6/4/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum UserServiceError: Error {
    case noResponse

    var localizedDescription: String {
        return String(describing: self)
    }
}

class UserService: BaseApiService<UserResource> {
    static let sharedInstance = UserService()

    func login(_ email: String,
               password: String) -> Observable<User> {
        return request(for: .login(email, password), at: "user")
                .map { [weak self] (user: User, response: Response) in
                    guard let headers = response.response?.allHeaderFields else {
                        throw UserServiceError.noResponse
                    }
                    return user
                }
    }

    func signup(_ email: String, password: String, avatar64: UIImage) -> Observable<User> {
        return request(for: .signup(email, password, avatar64), at: "user")
                .map { [weak self] (user: User, response: Response) in
                    guard let headers = response.response?.allHeaderFields else {
                        throw UserServiceError.noResponse
                    }
                    return user
                }
    }

    func getMyProfile() -> Observable<User> {
        return request(for: .profile, at: "user")
                .map { (user: User, response: Response) in
                    return user
                }
    }

    func loginWithFacebook(token: String) -> Observable<User> {
        return request(for: .fbLogin(token))
                .map { [weak self] (user: User, response: Response) in
                    guard let headers = response.response?.allHeaderFields else {
                        throw UserServiceError.noResponse
                    }
                    return user
                }
    }

    func logout() -> Observable<Void> {
        return requestWithNoResponse(for: UserResource.logout)
                .map { _ in
                    UserDataManager.deleteUser()
                    SessionManager.deleteSession()
                }
    }
}
