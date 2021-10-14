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
        
        guard let viewController = UIStoryboard.instantiateViewController(ProfessionBottomSheetViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
                   return
               }
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
         bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height:  self.view.frame.size.height * 0.5)
        present(bottomSheet, animated: true, completion: nil)
    }

}
