//
//  SettingsViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 05/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SDWebImage

class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var editProfileImageButton: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var shufflePracticeQuestionSwitch: UISwitch!
    @IBOutlet weak var shuffleStudyQuestionSwitch: UISwitch!
    @IBOutlet weak var showCorrectAnswerOnlySwitch: UISwitch!
    var viewModel : SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel.fetchUser()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func getViewModel() -> BaseViewModel {
        viewModel
    }
    
    // MARK: -Setup UI
    private func setupViews(){
        editProfileImageButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToEditProfile(_:))))
        
        userImageView.contentMode = .scaleToFill
        userImageView.makeCircular()
        
        shufflePracticeQuestionSwitch.isOn = LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHUFFLE_PRACTICE_QUESTION) ?? false
        
        shuffleStudyQuestionSwitch.isOn = LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHUFFLE_STUDY_QUESTION) ?? false
        
        
        showCorrectAnswerOnlySwitch.isOn = LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHOW_ONLY_CORRECT_QUESTION) ?? false
        
    }
    
    // MARK: - ViewModel
    private func bindViewModel() {
        viewModel.fetchUserState.subscribe(onNext: {user in
            guard let userDefaults = UserDataManager.currentUser else { return }
            guard let user = user else {
                self.userNameLabel.text = "\(userDefaults.firstName) \(userDefaults.lastName)"
                if let imageUrl = userDefaults.imageUrl {
                    self.userImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                    
                }
                return
            }
            self.userNameLabel.text = "\(user.firstName) \(user.lastName)"
            if let imageUrl = user.imageUrl {
                self.userImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    //MARK: - UI actions
    
    @IBAction func studyShuffleMode(_ sender: Any) {
        let state = LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHUFFLE_STUDY_QUESTION) ?? false
           LocalStorage.shared.persistBoolean(value: !state, key: StringIDs.PersistenceIdentifiers.SHUFFLE_STUDY_QUESTION)
    }
    
    @IBAction func studyShowCorrectAnswer(_ sender: Any) {
    }
    
    @IBAction func practiceShuffleMode(_ sender: Any) {
        let state = LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHUFFLE_PRACTICE_QUESTION) ?? false 
        LocalStorage.shared.persistBoolean(value: !state, key: StringIDs.PersistenceIdentifiers.SHUFFLE_PRACTICE_QUESTION)
    }
    
    @IBAction func practiceShowOnlyCOrrectAnswer(_ sender: Any) {
    }
    
    @IBAction func navigateToChangePassword(_ sender: Any) {
        print("Settings button clicked.....")
        guard let changePassword = UIStoryboard.instantiateViewController(ChangePasswordViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        print("Password story passed......")
        changePassword.viewModel = ChangePasswordViewModel()
        navigationController?.pushViewController(changePassword, animated: true)
    }
    
    
    @objc func navigateToEditProfile(_ sender: UITapGestureRecognizer){
        print("Settings arrow clicked.....")
        guard let editProfile = UIStoryboard.instantiateViewController(EditProfileViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        print("Settings arrow passed.....")
        editProfile.viewModel = EditProfileViewModel()
        navigationController?.pushViewController(editProfile, animated: true)
    }
    
}
