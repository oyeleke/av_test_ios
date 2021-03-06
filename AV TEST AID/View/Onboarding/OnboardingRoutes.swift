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
    case passwordOtp
    case resetPassword
    case welcome
    case profilePicture
    case profile

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
        case .passwordOtp:
            return buildPasswordOtpViewController()
        case .resetPassword:
            return buildResetPasswordViewController()
        case .welcome:
            return buildWelcomeViewController()
        case .profilePicture:
            return buildProfilePictureViewController()
        case .profile:
            return buildProfileViewController()
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
        signUp.viewModel = SignUpViewModel()
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

    private func buildPasswordOtpViewController() -> UIViewController {
        guard let passwordOtp = UIStoryboard
                .instantiateViewController(PasswordOTPViewController.self)
                else {
            return UIViewController()
        }
        passwordOtp.viewModel = PasswordOTPViewModel()
        return passwordOtp
    }

    private func buildResetPasswordViewController() -> UIViewController {
        guard let resetPassword = UIStoryboard
                .instantiateViewController(ResetPasswordViewController.self)
                else {
            return UIViewController()
        }
        resetPassword.viewModel = ResetPasswordViewModel()
        return resetPassword
    }

    private func buildWelcomeViewController() -> UIViewController {
        guard let welcome = UIStoryboard
                .instantiateViewController(WelcomeViewController.self)
                else {
            return UIViewController()
        }
        welcome.viewModel = WelcomeViewModel()
        return welcome
    }

    private func buildProfilePictureViewController() -> UIViewController {
        guard let profilePicture = UIStoryboard
                .instantiateViewController(ProfilePictureViewController.self)
                else {
            return UIViewController()
        }
        profilePicture.viewModel = ProfilePictureViewModel()
        return profilePicture
    }

    private func buildProfileViewController() -> UIViewController {
        guard let profile = UIStoryboard
                .instantiateViewController(ProfileViewController.self)
                else {
            return UIViewController()
        }
        profile.viewModel = ProfileViewModel()
        return profile
    }

}
