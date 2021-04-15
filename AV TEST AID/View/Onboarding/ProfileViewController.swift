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

class ProfileViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var licenseNumberField: MDCTextField!
    @IBOutlet weak var professionView: CustomDropDownView!
    @IBOutlet weak var nationalityView: CustomDropDownView!
    @IBOutlet weak var selectedProfessionLabel: UILabel!
    @IBOutlet weak var selectedNationalityLabel: UILabel!

    private var licenseNumberController: OutlinedTextInputController!

    // MARK: - LifeCycle Events

    var viewModel: ProfileViewModel!

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
        viewModel.professions.subscribe(onNext: { professions in
            self.professionView.setDropDownData(professions: professions)
        }).disposed(by: disposeBag)

        viewModel.nations.subscribe(onNext: { nations in
            self.nationalityView.setDropDownData(nations)
        }).disposed(by: disposeBag)
    }

    private func setupViews() {
        licenseNumberController = OutlinedTextInputController(textInput: licenseNumberField)
        professionView.setLabelView(label: selectedProfessionLabel)
        nationalityView.setLabelView(label: selectedNationalityLabel)
    }

    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions

    @objc func skipTapped() {
        viewModel.navigateToHome()
    }

    @IBAction func doneTapped(_ sender: UIButton) {
        Validator.clearErrors(textControllers: licenseNumberController)

        guard let selectedProfessionIndex = professionView.getSelectedIndex() else {
            showMessage(title: "", message: "Please select your profession")
            return
        }
        if !Validator.validate(textControllers: licenseNumberController) { return }
        guard let selectedNationality = nationalityView.getSelectedItem() else {
            showMessage(title: "", message: "Please select your nationality")
            return
        }

        viewModel.onboardUser(professionIndex: selectedProfessionIndex, licenseNumber: licenseNumberField.text!, nationality: selectedNationality)
    }

}
