//
//  EditProfileViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 12/05/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//
import Foundation
import UIKit
import MaterialComponents
import SDWebImage

class EditProfileViewController: BaseViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userNameField: MDCTextField!
    private var userNameController: OutlinedTextInputController!
    
    @IBOutlet weak var usersEmailField: MDCTextField!
    private var emailController: OutlinedTextInputController!
    
    @IBOutlet weak var usersLicenseNumberField: MDCTextField!
    private var usersLicenseNumberController: OutlinedTextInputController!
    
    var profilePicture: UIImage? = nil
    var imageName = ""
    private let imagePicker = UIImagePickerController()
    var viewModel : EditProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupViews(){
        userImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProfilePictureTapped(_:))))
        userImage.contentMode = .scaleToFill
        userImage.makeCircular()
        userNameController = OutlinedTextInputController(textInput: userNameField)
        emailController = OutlinedTextInputController(textInput: usersEmailField)
        usersLicenseNumberController = OutlinedTextInputController(textInput: usersLicenseNumberField)
        
        guard let userDefaults = UserDataManager.currentUser else { return }
        if let imageUrl = userDefaults.imageUrl {
            self.userImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            
        }
        userNameField.text = "\(userDefaults.firstName) \(userDefaults.lastName)"
        usersEmailField.text = "\(userDefaults.email)"
        usersLicenseNumberField.text = "\(userDefaults.licenseNumber ?? "")"
    }
    
    override func getViewModel() -> BaseViewModel {
        viewModel
    }
    
    @objc func onProfilePictureTapped(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
}

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            showDialog(withMessage: "There was an error processing your image. Please try again.")
            return
        }
        
        if let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(fileUrl.lastPathComponent)
            imageName = fileUrl.lastPathComponent
        }
        
        userImage.contentMode = .scaleToFill
        userImage.makeCircular()
        userImage.image = image
        profilePicture = image
        
        guard let selectedImage = profilePicture else {
            showDialog(withMessage: "Please select an image to upload")
            return
        }
        
        viewModel.uploadImage(selectedImage, imageName: imageName)
    }
    
}
