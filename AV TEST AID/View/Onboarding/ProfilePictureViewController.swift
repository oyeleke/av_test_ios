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

class ProfilePictureViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pictureImageView: UIImageView!

    // MARK: - LifeCycle Events

    var viewModel: ProfilePictureViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipTapped))
    }

    private func bindToViewModel() {

    }

    // MARK: - Actions

    @objc func skipTapped() {
        viewModel.goToProfile()
    }

    @IBAction func addPhotoTapped(_ sender: UIButton) {
        viewModel.goToProfile()
    }

}
