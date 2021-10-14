//
//  ReviewQuestionsViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 06/10/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class ReviewQuestionsViewController: BaseViewController {
    @IBOutlet weak var currentQuestionNumberLabel: UILabel!
    @IBOutlet weak var totalQuestionsUILabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var option1TextLabel: UILabel!
    @IBOutlet weak var option1Layout: CustomOptionView!
    @IBOutlet weak var option2TextLabel: UILabel!
    @IBOutlet weak var option2Layout: CustomOptionView!
    @IBOutlet weak var option3TextLabel: UILabel!
    @IBOutlet weak var option3Layout: CustomOptionView!
    @IBOutlet weak var option4TextLabel: UILabel!
    @IBOutlet weak var option4Layout: CustomOptionView!
    @IBOutlet weak var previousButton: CustomDesignableButton!
    @IBOutlet weak var endReviewButton: CustomDesignableButton!
    @IBOutlet weak var nextQuestionButton: CustomDesignableButton!
    @IBOutlet weak var markQuestionsImage: UIImageView!
    var optionsLabelList: [UILabel]!
    var optionsLayoutList : [CustomOptionView]!
    var realm : Realm!
    var viewModel : ReviewQuestionViewModel!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        setupViews()
        subscribeObservers()
    }
    
    override func getViewModel() -> BaseViewModel {
        return viewModel
    }
    
    // MARK : Actions
    @IBAction func onNextPressed(_ sender: Any) {
        viewModel.onNextPressed()
    }
    
    
    @IBAction func onPreviousPressed(_ sender: Any) {
        viewModel.onOnPrevPressed()
    }
    
    
    @IBAction func onEndReviewButtonPressed(_ sender: Any) {
    }
    
    // MARK :  View setup
    
    
    private func setupViews(){
        optionsLabelList = [option1TextLabel, option2TextLabel, option3TextLabel, option4TextLabel]
        optionsLayoutList = [option1Layout, option2Layout, option3Layout, option4Layout]
         markQuestionsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onQuestionBookmarked(_:))))
        viewModel.setupQuestionsForReview(realm: realm)
        totalQuestionsUILabel.text = "\(viewModel.totalQuestions)"
    
    }
    
    private func updateQuestion(questionSessionItem: QuestionSessionItem){
        resetQuestion()
        if(viewModel.currentQuestionNumber == 0){
              previousButton.isHidden = true
          } else {
              previousButton.isHidden = false
          }
          
          if(viewModel.currentQuestionNumber+1 == viewModel.totalQuestions){
              nextQuestionButton.isHidden = true
              endReviewButton.isHidden = false
          } else {
              nextQuestionButton.isHidden = false
              endReviewButton.isHidden = true
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
                optionsLabelList[i].text = option.text
                optionsLayoutList[i].alpha = 1
                if option.isCorrect{
                    optionsLayoutList[i].optionStateColor = OptionStates.OptionIsCorrect
                }
                
                if let optionSelected = viewModel.currentSessionOptionList[questionSessionItem.questionId ?? ""] {
                    if optionSelected.optionId == option.id && !optionSelected.isCorrect{
                        optionsLayoutList[i].optionStateColor = OptionStates.OptionIsWrong
                    }
                }
                i = i+1;
            }
        }
        
    }
    
    @objc func onQuestionBookmarked(_ sender: UITapGestureRecognizer){
        print("book marked question")
        let onMarkedQuestions = MarkedQuestions.onQuestionMarkedStateChanged(forQuestionWithId: viewModel.currentQuestion.value?.questionId ?? "", realm)
        switch onMarkedQuestions {
        case MarkedQuestionStates.QUESTION_MARKED:
            
            viewModel.markedQuestionSet.insert(viewModel.currentQuestion.value?.questionId ?? "")
            markQuestionsImage.image = UIImage(named: "bookmarked")
            break
        case MarkedQuestionStates.MARKED_QUESTION_REMOVED:
            viewModel.markedQuestionSet.remove(viewModel.currentQuestion.value?.questionId ?? "")
            markQuestionsImage.image = UIImage(named: "bookmark")
            break
        case MarkedQuestionStates.ERROR:
            print("ERORR State did not change")
            break
        }
    }
    
    private func subscribeObservers(){
        viewModel.currentQuestion.subscribe(onNext: {questionSessionItem in
                guard let questionSessionItem = questionSessionItem else {return}
                self.updateQuestion(questionSessionItem: questionSessionItem)
            })
    }
    
    fileprivate func resetOptions() {
        for optionLayout in optionsLayoutList{
            optionLayout.optionStateColor = OptionStates.OptionNotSelected
        }
    }
    
    
    fileprivate func resetQuestion() {
        markQuestionsImage.image = UIImage(named: "bookmark")
        resetOptions()
    }
}
