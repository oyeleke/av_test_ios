//
//  ProfilePictureViewModel.swift
//  AV TEST AID
//
//  Created by Efe Ejemudaro on 01/04/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit
import AlamofireImage

class ProfilePictureViewModel: BaseViewModel {
    
    func uploadImage(_ image: UIImage, imageName: String) {
        guard let imageData = getScaledImage(image) else {
            self.state.accept(.error("There was an error processing your image. Please try again."))
            return
        }
        
        state.accept(.loading(""))
        
        AVTestService.sharedInstance
                .uploadImage(imageData, name: imageName)
                .subscribe(onNext: { user in
                    self.state.accept(.idle)
                    self.navigateToProfile()
                }, onError: { [weak self] error in
                    if let apiError = error as? APIError {
                        self?.state.accept(.error(apiError.errorMessage))
                    } else {
                        self?.state.accept(.error(error.localizedDescription))
                    }
                }).disposed(by: disposeBag)
    }
    
    func getScaledImage(_ image: UIImage) -> Data? {
        let scaledImage = image.af_imageScaled(to: CGSize(width: 600, height: 400))
        return scaledImage.jpegData(compressionQuality: 0.8)
    }
    
    func navigateToProfile() {
        AppNavigator.shared.navigate(to: OnboardingRoutes.profile, with: .push)
    }
    
}
