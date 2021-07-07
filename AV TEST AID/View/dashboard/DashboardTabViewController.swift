//
//  DashboardTabViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 05/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit

class DashboardTabViewController: UITabBarController, UITabBarController.Delegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupViewControllers()
        
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        switch viewController {
        case tabBarController.viewControllers?[0]:
            let vc  = (tabBarController.viewControllers?[0] ) as! UINavigationController
            guard let dashboardViewController = UIStoryboard.instantiateViewController(DashboardViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
                return false
            }
            
            dashboardViewController.viewModel = QuestionsViewModel()
            vc.pushViewController(dashboardViewController, animated: true)
            return true
            
        case tabBarController.viewControllers?[2]:
            let vc  = (tabBarController.viewControllers?[2] ) as! UINavigationController
            guard let settingsViewController = UIStoryboard.instantiateViewController(SettingsViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
                return false
            }
            
            settingsViewController.viewModel = SettingsViewModel()
            vc.pushViewController(settingsViewController, animated: true)
            return true
            
        default:
            return true
        }
    }
}
