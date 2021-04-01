//
//  OnboardingRoutes.swift
//  AV TEST AID
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

enum OnboardingRoutes: Route {
    
    case firstScreen
    case signIn
    case signUp
    case otp
    case forgotPassword
    
    var screen: UIViewController {
        switch self {
        case .firstScreen:
            return buildFirstViewController()
        case .signIn:
            return buildSignInViewController()
        case .signUp:
            return buildSignUpViewController()
        case .otp:
            return buildOTPViewController()
        case .forgotPassword:
            return buildForgotPasswordViewController()
        }
    }
    
    private func buildSignInViewController() -> UIViewController {
        guard let signIn = UIStoryboard
                .instantiateViewController(SignInViewController.self)
        else {
            return UIViewController()
        }
        signIn.viewModel = SignInViewModel()
        return signIn
    }
    
    private func buildSignUpViewController() -> UIViewController {
        guard let signUp = UIStoryboard
                .instantiateViewController(SignUpViewController.self)
        else {
            return UIViewController()
        }
        signUp.viewModel = SignUpViewModelWithEmail()
        return signUp
    }
    
    private func buildFirstViewController() -> UIViewController {
        guard let first = UIStoryboard
                .instantiateViewController(FirstViewController.self)
        else {
            return UIViewController()
        }
        first.viewModel = FirstViewModel()
        return first
    }
    
    private func buildOTPViewController() -> UIViewController {
        guard let otp = UIStoryboard
                .instantiateViewController(OTPViewController.self)
        else {
            return UIViewController()
        }
        otp.viewModel = OTPViewModel()
        return otp
    }
    
    private func buildForgotPasswordViewController() -> UIViewController {
        guard let forgotPassword = UIStoryboard
                .instantiateViewController(ForgotPasswordViewController.self)
        else {
            return UIViewController()
        }
        forgotPassword.viewModel = ForgotPasswordViewModel()
        return forgotPassword
    }
    
}
