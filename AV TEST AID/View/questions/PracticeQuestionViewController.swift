//
//  PracticeQuestionViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 23/09/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class PracticeQuestionViewController: BaseViewController{
    
    @IBOutlet weak var totalQuestions: UILabel!
    @IBOutlet weak var currentQuestionNumber: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var option1Text: UILabel!
    @IBOutlet weak var option2Text: UILabel!
    @IBOutlet weak var option3Text: UILabel!
    @IBOutlet weak var option4Text: UILabel!
    @IBOutlet weak var nextQuestionButton: CustomDesignableButton!
    @IBOutlet weak var previousQuestionButton: CustomDesignableButton!
    @IBOutlet weak var reviewQuestionButton: CustomDesignableButton!
    @IBOutlet weak var option1View: CustomOptionView!
    @IBOutlet weak var option2View: CustomOptionView!
    @IBOutlet weak var option3View: CustomOptionView!
    @IBOutlet weak var option4View: CustomOptionView!
    @IBOutlet weak var markQuestionsImage: UIImageView!
    var viewModel : QuestionsViewModel!
    var realm: Realm!
    var profession : Profession!
    var mQuestionSessionItem: QuestionSessionItem!
    
    var optionTextList : [UILabel]!
    var optionsContainerList: [CustomOptionView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm  = try! Realm()
          setupQuestions(realm: realm, profession: profession)
        setupViews()
        subscribeObservers()
        
        // Do any additional setup after loading the view.
    }
    
    func setupViews(){
        optionTextList = [option1Text, option2Text, option3Text, option4Text]
        optionsContainerList = [option1View, option2View, option3View, option4View]
        option1View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped0(_:))))
        option2View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped1(_:))))
        option3View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped2(_:))))
        option4View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped3(_:))))
        markQuestionsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onQuestionBookmarked(_:))))
    }
    
    override
    func getViewModel() -> BaseViewModel {
        viewModel
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func moveToNextQuestion(_ sender: Any) {
        viewModel.moveToNextQuestion(realm)
        
    }
    
    @IBAction func moveToPreviousQuestion(_ sender: Any) {
        viewModel.moveToPreviousQuestion(realm)
        
    }
    
    private func setupQuestions(realm: Realm, profession: Profession){
        viewModel.setUpPracticeQuestions(realm: realm, id: profession.id)
        self.totalQuestions.text = "\(viewModel.totalQuestions)"
    }
    
    @IBAction func moveToResultPage(_ sender: Any) {
        guard let resultsViewController = UIStoryboard.instantiateViewController(QuestionScoresViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        resultsViewController.questionScoresViewControllerDelegate = self
        if let questionSessionStats = QuestionSession.getSessionStats(realm){
            resultsViewController.missed = questionSessionStats.1 - questionSessionStats.0
            resultsViewController.scorePercentage = (questionSessionStats.0 * 100) / questionSessionStats.1
            resultsViewController.totalQuestionNumber = questionSessionStats.1
        }
        present(resultsViewController, animated: true, completion: nil)
    }
    
    
    private func subscribeObservers(){
        viewModel.currentQuestion.subscribe(onNext: {question in
            //print("question: \(question?.questionId)")
            guard let question = question else {return}
            self.mQuestionSessionItem = question
            self.updateQuestion(questionSessionItem: question)
        })
    }
    
    private func updateQuestion(questionSessionItem: QuestionSessionItem){
        resetQuestion()
        if(viewModel.currentQuestionNumber == 0){
            previousQuestionButton.isHidden = true
        } else {
            previousQuestionButton.isHidden = false
        }
        
        if(viewModel.currentQuestionNumber+1 == viewModel.totalQuestions){
            nextQuestionButton.isHidden = true
            reviewQuestionButton.isHidden = false
        } else {
            nextQuestionButton.isHidden = false
            reviewQuestionButton.isHidden = true
        }
        
        if  viewModel.markedQuestionSet.contains(questionSessionItem.questionId ?? ""){
            markQuestionsImage.image = UIImage(named: "bookmarked")
        }
        
        questionText.text = questionSessionItem.question?.text
        if(viewModel.currentQuestionNumber < 9){
            currentQuestionNumber.text = "0\(viewModel.currentQuestionNumber + 1)"
        } else {
            currentQuestionNumber.text = "\(viewModel.currentQuestionNumber + 1)"
        }
        
        var i = 0;
        var optionSelectedId = ""
        if let optionGottenId = viewModel.questionIdOptionChosenIdDictionary[questionSessionItem.questionId ?? ""] {
            optionSelectedId = optionGottenId
        }
        
        if let options = questionSessionItem.question?.options{
            for option in options{
                optionTextList[i].text = option.text
                optionsContainerList[i].alpha = 1
//                if option.isCorrect{
//                    optionsContainerList[i].optionStateColor = OptionStates.OptionIsCorrect
//                }
                if option.id == optionSelectedId{
                    optionsContainerList[i].optionStateColor = OptionStates.OptionSelected
                }
                i = i+1;
            }
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
    
    fileprivate func resetOptions() {
        for optionLayout in optionsContainerList{
            optionLayout.optionStateColor = OptionStates.OptionNotSelected
        }
    }
    
    fileprivate func resetQuestion() {
        markQuestionsImage.image = UIImage(named: "bookmark")
        resetOptions()
    }
    
    func onOptionClicked(index: Int){
        if  mQuestionSessionItem?.question?.options[index] != nil  {
            viewModel.onOptionChosen(forQuestionId: mQuestionSessionItem?.questionId ?? "", option:  (mQuestionSessionItem?.question?.options[index])!, realm: realm)
            resetOptions()
            optionsContainerList[index].optionStateColor = OptionStates.OptionSelected
        }
    }
}

extension PracticeQuestionViewController : QuestionScoresViewControllerProtocol {
    func onRetakeQuestionsCalled() {
        guard let reviewQuestionsViewController = UIStoryboard.instantiateViewController(ReviewQuestionsViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        reviewQuestionsViewController.viewModel = ReviewQuestionViewModel()
        navigationController?.pushViewController(reviewQuestionsViewController, animated: true)
    }
    
    func onReviewQuestions() {
        
    }
    
    
}
