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
    
    func changePassword(changeRequest: ChangePasswordRequest) -> Observable<Bool> {
        requestWithNoResponse(for: .changePassword(changeRequest)).map{_ in
            return true
        }
    }
    
    func signIn(signInRequest: SignInUserRequest) -> Observable<User> {
        request(for: .signIn(signInRequest))
            .map { (signInResponse: SignInUserResponse, response: Response) in
                SessionManager.start(session: Session(accessToken: signInResponse.tokenData.token))
                UserDataManager.set(user: signInResponse.user)
                return signInResponse.user
        }
    }
    
    func fetchUser() -> Observable<User> {
        request(for: .fetchUserProfile)
            .map { (user: User, response: Response) in
                UserDataManager.set(user: user)
                return user
        }
    }
    
    func fetchQuestions() -> Observable<[QuestionRest]> {
        request(for: .fetchQuestions).asObservable().map {
            (questionsPagedResponse : [QuestionRest], response: Response) in
            questionsPagedResponse
        }
    }
    
    func fetchScores() -> Observable<Double> {
        request(for: .fetchScore).asObservable().map {
            (score: Double, response: Response) in
            score
        }
    }
    
    func uploadImage(_ imageData: Data, name imageName: String) -> Observable<User> {
        request(for: .uploadImage(imageData, imageName))
            .map({ (user: User, response: Response) in
                UserDataManager.set(user: user)
                return user
            })
    }
    
    func fetchProfessions() -> Observable<[Profession]> {
        request(for: .fetchProfessions)
            .map { (professions: [Profession], response: Response) in
                professions
        }
    }
    
    func updateProfession(professionKey: String) -> Observable<Profession> {
        request(for: .updateProfession(professionKey))
            .map { (profession: Profession, response: Response) in
                profession
        }
    }
    
    func onboardUser(onboardRequest: OnboardUserRequest) -> Observable<User> {
        request(for: .onboardUser(onboardRequest))
            .map { (user: User, response: Response) in
                user
        }
    }
}
