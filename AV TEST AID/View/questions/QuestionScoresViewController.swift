//
//  QuestionScoresViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 30/09/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit

class QuestionScoresViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoresTextUILabel: UILabel!
    @IBOutlet weak var scoresCircularImageView: UIImageView!
    @IBOutlet weak var reviewFailedQuestionLayout: UIView!
    @IBOutlet weak var retakeQuestionSessionLayout: UIView!
    
    var questionScoresViewControllerDelegate : QuestionScoresViewControllerProtocol!
    var scorePercentage : Int!
    var missed: Int!
    var totalQuestionNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpView(){
        scoreLabel.text = "\(scorePercentage!)%"
        scoresTextUILabel.text = "YOU MISSED \(missed!)/\(totalQuestionNumber!)"
        reviewFailedQuestionLayout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(reviewQuestions(_:))))
        retakeQuestionSessionLayout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(retakePracticeQuestion(_:))))
    }
    
    
    @objc func reviewQuestions(_ sender: UITapGestureRecognizer){
        print("review questions clicked")
        questionScoresViewControllerDelegate.onRetakeQuestionsCalled()
        dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
    }
    
    @objc func retakePracticeQuestion(_ sender: UITapGestureRecognizer){
        print("retake practice question")
        navigationController?.popViewController(animated: true)
    }

}

protocol QuestionScoresViewControllerProtocol {
   func onRetakeQuestionsCalled()
    func onReviewQuestions()
}
