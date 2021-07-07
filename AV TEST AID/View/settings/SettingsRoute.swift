//
//  SettingsRoute.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 05/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

enum SettingsRoute : Route {
    
    case changePassword
    case editProfile
    
    var screen: UIViewController {
        switch self {
        case .changePassword:
            return buildChangePasswordViewController()
        case .editProfile:
            return buildEditProfileViewController()
        }
    }
    
    private func buildChangePasswordViewController() -> UIViewController {
        guard let changePassword = UIStoryboard.instantiateViewController(ChangePasswordViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return UIViewController()
        }
        changePassword.viewModel = ChangePasswordViewModel()
        return changePassword
    }
    
    private func buildEditProfileViewController() -> UIViewController{
        guard let editProfile = UIStoryboard.instantiateViewController(EditProfileViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return UIViewController()
        }
        
        editProfile.viewModel = EditProfileViewModel()
        return editProfile
    }
}
