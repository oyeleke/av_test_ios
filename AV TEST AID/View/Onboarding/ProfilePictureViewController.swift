//
//  ProfilePictureViewController.swift
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

class ProfilePictureViewController: BaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var pictureImageView: UIImageView!

    // MARK: - LifeCycle Events

    var viewModel: ProfilePictureViewModel!
    var profilePicture: UIImage? = nil
    var imageName = ""
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipTapped))
    }
    
    
    func setupViews() {
        pictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onProfilePictureTapped(_:))))
    }
    
    override func getViewModel() -> BaseViewModel {
        viewModel
    }

    // MARK: - Actions
    
    @objc func onProfilePictureTapped(_ sender: UITapGestureRecognizer) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    @objc func skipTapped() {
        viewModel.navigateToProfile()
    }

    @IBAction func addPhotoTapped(_ sender: UIButton) {
        guard let selectedImage = profilePicture else {
            showDialog(withMessage: "Please select an image to upload")
            return
        }
        
        viewModel.uploadImage(selectedImage, imageName: imageName)
    }

}

extension ProfilePictureViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        
        pictureImageView.contentMode = .scaleToFill
        pictureImageView.makeCircular()
        pictureImageView.image = image
        profilePicture = image
    }
    
}
