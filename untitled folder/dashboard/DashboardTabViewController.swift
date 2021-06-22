//
//  DashboardTabViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 06/05/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit

class DashboardTabViewController: UITabBarController, UITabBarController.Delegate {
    
    var viewModel: DashboardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //setupViewControllers()
        print("=========== tab bar controller view did load")
        self.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("============== tabBar controllerp")
        switch viewController {
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
        
        return false
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("============== tabBar controller")
        print(viewController.nibName ?? "===== tabcontroller")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

