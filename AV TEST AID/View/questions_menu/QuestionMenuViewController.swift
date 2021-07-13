//
//  QuestionMenuViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 05/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialBottomSheet

class QuestionMenuViewController: UIViewController {

    @IBOutlet weak var studyQuestionsImage: UIImageView!
    @IBOutlet weak var practiceQuestionImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
        
    private func setupViews(){
        practiceQuestionImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPracticeQuestionTouched(_:))))
    }
    
    @objc func onPracticeQuestionTouched(_ sender: UITapGestureRecognizer){
        print("it =============================== got here ========== ")
        let viewController : UIViewController = ProfessionBottomSheetViewController()
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
        present(bottomSheet, animated: true, completion: nil)
    }

}
