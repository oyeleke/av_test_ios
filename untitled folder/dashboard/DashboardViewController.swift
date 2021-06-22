//
//  DashboardViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//


import Foundation
import UIKit
import RxCocoa
import RxSwift
import MaterialComponents
import DropDown


class DashboardViewController: UIViewController {

    @IBOutlet weak var searchTextField: MDCTextField!
    
    var viewModel: DashboardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchButton()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func refresh(_ sender: Any) {
    }

    func setupSearchButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings_menu_inactive.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(300), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
//        searchTextField.rightView = button
//        searchTextField.rightViewMode = .always
    }
}
