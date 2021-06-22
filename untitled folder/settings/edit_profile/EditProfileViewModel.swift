//
//  EditProfileViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 12/05/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import AlamofireImage

class EditProfileViewModel : BaseViewModel {
    
    let uploadImageState = BehaviorRelay(value: false)
    
    func uploadImage(_ image: UIImage, imageName: String) {
        guard let imageData = getScaledImage(image) else {
            self.state.accept(.error("There was an error processing your image. Please try again."))
            return
        }
        state.accept(.loading("Uploading Image"))
        AVTestService.sharedInstance
            .uploadImage(imageData, name: imageName)
            .subscribe(onNext: { user in
                self.state.accept(.idle)
                self.uploadImageState.accept(true)
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
    
}
