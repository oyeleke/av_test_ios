//
//  StudyQuestionsViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 13/10/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import RxSwift
import RxCocoa

class StudyQuestionsViewController: BaseViewController {
    @IBOutlet weak var filterUILabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var backButton: CustomDesignableButton!
    @IBOutlet weak var currentQuestionNumberLabel: UILabel!
    @IBOutlet weak var totalQuestionNumberLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var markQuestionsImage: UIImageView!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option1Layout: CustomOptionView!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option2Layout: CustomOptionView!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var option3Layout: CustomOptionView!
    @IBOutlet weak var option4Label: UILabel!
    @IBOutlet weak var option4Layout: CustomOptionView!
    @IBOutlet weak var previousButton: CustomDesignableButton!
    @IBOutlet weak var nextButton: CustomDesignableButton!
    var mQuestionSessionItem: QuestionSessionItem!
    var optionTextList : [UILabel]!
    var optionsContainerList: [CustomOptionView]!
    
    var realm: Realm!
    var viewModel : QuestionsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func onPreviousButtonClicked(_ sender: Any) {
    }
    
    @IBAction func onNextButtonClicked(_ sender: Any) {
    }
    
    
    
    
    func setupViews(){
        topicLabel.text = "All"
        optionTextList = [option1Label, option2Label, option3Label, option4Label]
        optionsContainerList = [option1Layout, option2Layout, option3Layout, option4Layout]
        option1Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped0(_:))))
        option2Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped1(_:))))
        option3Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped2(_:))))
        option4Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped3(_:))))
        markQuestionsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onQuestionBookmarked(_:))))
    }
    
    func subscribeObservers(){
        
    }
    
    
    fileprivate func resetOptions() {
        for optionLayout in optionsContainerList{
            optionLayout.optionStateColor = OptionStates.OptionNotSelected
        }
    }
    
    fileprivate func resetQuestion() {
        markQuestionsImage.image = UIImage(named: "bookmark")
        resetOptions()
    }
    
        private func updateQuestion(questionSessionItem: QuestionSessionItem){
            resetQuestion()
            if(viewModel.currentQuestionNumber == 0){
                previousButton.isHidden = true
            } else {
                previousButton.isHidden = false
            }
            
            if(viewModel.currentQuestionNumber+1 == viewModel.totalQuestions){
                nextButton.isHidden = true
            } else {
                nextButton.isHidden = false
            }
            
            if  viewModel.markedQuestionSet.contains(questionSessionItem.questionId ?? ""){
                markQuestionsImage.image = UIImage(named: "bookmarked")
            }
            
            questionTextLabel.text = questionSessionItem.question?.text
            if(viewModel.currentQuestionNumber < 9){
                currentQuestionNumberLabel.text = "0\(viewModel.currentQuestionNumber + 1)"
            } else {
                currentQuestionNumberLabel.text = "\(viewModel.currentQuestionNumber + 1)"
            }
            
            var i = 0;
   
            if let options = questionSessionItem.question?.options{
                for option in options{
                    optionTextList[i].text = option.text
                    optionsContainerList[i].alpha = 1
                    if option.isCorrect {
                        optionsContainerList[i].optionStateColor = OptionStates.OptionIsCorrect
                    }
                     i = i+1;
                }
            }
            
            
        }
    
    //MARK: - Gesture Recognizer
    
    @objc func onQuestionBookmarked(_ sender: UITapGestureRecognizer){
        print("book marked question")
        let onMarkedQuestions = MarkedQuestions.onQuestionMarkedStateChanged(forQuestionWithId: mQuestionSessionItem.questionId ?? "", realm)
        switch onMarkedQuestions {
        case MarkedQuestionStates.QUESTION_MARKED:
            viewModel.markedQuestionSet.insert(mQuestionSessionItem.questionId ?? "")
            markQuestionsImage.image = UIImage(named: "bookmarked")
            break
        case MarkedQuestionStates.MARKED_QUESTION_REMOVED:
            viewModel.markedQuestionSet.remove(mQuestionSessionItem.questionId ?? "")
            markQuestionsImage.image = UIImage(named: "bookmark")
            break
        case MarkedQuestionStates.ERROR:
            print("ERORR State did not change")
            break
        }
    }
    
    @objc func onOptionTapped0(_ sender: UITapGestureRecognizer){
        onOptionClicked(index: 0)
    }
    
    @objc func onOptionTapped1(_ sender: UITapGestureRecognizer){
        onOptionClicked(index: 1)
    }
    
    @objc func onOptionTapped2(_ sender: UITapGestureRecognizer){
        onOptionClicked(index: 2)
    }
    
    @objc func onOptionTapped3(_ sender: UITapGestureRecognizer){
        onOptionClicked(index: 3)
    }

    func onOptionClicked(index: Int){
   
    }
}
