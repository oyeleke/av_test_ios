//
//  KnowledgeScoreViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 19/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import SDWebImage

@available(iOS 13.0, *)
class KnowledgeScoreViewController: BaseViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfessionLabel: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    
    var viewModel : KnowledgeScoreViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        bindViewModel()
        viewModel.fetchScore()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setUpView() {
        userImage.contentMode = .scaleToFill
        userImage.makeCircular()
        guard let userDefaults = UserDataManager.currentUser else { return }
        self.userName.text = "\(userDefaults.firstName) \(userDefaults.lastName)"
        self.userProfessionLabel.text = userDefaults.profession
        if let imageUrl = userDefaults.imageUrl {
            self.userImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
            
        }
    }
    
    func bindViewModel(){
        viewModel.fetchScoreState.subscribe(onNext: {score in
            self.ratingView.setStarsFor(rating: Float(score))
        }).disposed(by: disposeBag)
    }
    
    override func getViewModel() -> BaseViewModel {
        viewModel
    }
    
    
    @IBAction func keepPracticingView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
