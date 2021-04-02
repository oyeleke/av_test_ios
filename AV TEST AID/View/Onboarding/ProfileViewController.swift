//
//  ProfileViewController.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import MaterialComponents
import DropDown

class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var licenseNumberField: MDCTextField!
    @IBOutlet weak var professionView: UIView!
    @IBOutlet weak var nationalityView: UIView!
    
    private var licenseNumberController: OutlinedTextInputController!
    private var professionDropDown: DropDown!
    
    // MARK: - LifeCycle Events
    
    var viewModel: ProfileViewModel!
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        setupViews()
    }
    
    private func bindToViewModel() {
        
    }
    
    private func setupViews() {
        licenseNumberController = OutlinedTextInputController(textInput: licenseNumberField)
        
        professionDropDown = DropDown()
        professionDropDown.anchorView = professionView
        professionDropDown.dataSource = ["Pilot", "Flight Attendant", "Flight Disparcher", "Air Traffic Controller", "Engineer"]
        professionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.professionViewTapped(_:))))
        DropDown.appearance().textColor = UIColor(named: "darkBlueTextColor")!
        DropDown.appearance().selectedTextColor = UIColor(named: "aviBlue")!
        DropDown.appearance().textFont = UIFont(name: "Quicksand-SemiBold", size: CGFloat(17))!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.white
        
    }
    
    // MARK: - Actions
    
    @objc func skipTapped() {
        
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
    }
    
    @objc func professionViewTapped(_ sender: UITapGestureRecognizer) {
        professionDropDown.show()
    }
    
}
