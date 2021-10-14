//
//  MarkedQuestionsViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 07/10/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class MarkedQuestionsViewController: BaseViewController {
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionTextUILabel: UILabel!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option1Layout: CustomOptionView!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option2Layout: CustomOptionView!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet weak var option3Layout: CustomOptionView!
    @IBOutlet weak var option4Label: UILabel!
    @IBOutlet weak var option4Layout: CustomOptionView!
    @IBOutlet weak var nextButton: CustomDesignableButton!
    @IBOutlet weak var prevButton: CustomDesignableButton!
    @IBOutlet weak var markQuestionsImage: UIImageView!
    
    var optionsLabelList: [UILabel]!
    var optionsLayoutList : [CustomOptionView]!
    var realm : Realm!
    var viewModel : MarkedQuestionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        setupViews()
        subscribeObservers()
        // Do any additional setup after loading the view.
    }
    
    override func getViewModel() -> BaseViewModel {
        return viewModel
    }
    // MARK: - Button Actions
    
    @IBAction func onNextPressed(_ sender: Any) {
        viewModel.onNextPressed()
    }
    
    @IBAction func onPrevPressed(_ sender: Any) {
        viewModel.onPrevPressed()
    }
    
    // MARK: - UI Updates
    func setupViews(){
        optionsLabelList = [option1Label, option2Label, option3Label, option4Label]
        optionsLayoutList = [option1Layout, option2Layout, option3Layout, option4Layout]
        markQuestionsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onQuestionBookmarked(_:))))
        viewModel.setupMarkedQuestion(realm)
    }
    
    func subscribeObservers(){
        viewModel.currentQuestion.subscribe(onNext: {questionItem in
            guard let question = questionItem else {return}
            self.updateQuestion(question: question)
        })
    }
    
    
    
    func updateQuestion(question: Question){
        resetQuestion()
        if(viewModel.currentQuestionNumber == 0){
            prevButton.isHidden = true
        } else {
            prevButton.isHidden = false
        }
        
        if(viewModel.currentQuestionNumber+1 == viewModel.totalQuestions){
            nextButton.isHidden = true
            
        } else {
            nextButton.isHidden = false
        }
        
        questionTextUILabel.text = question.text
        if(viewModel.currentQuestionNumber < 9){
            questionNumber.text = "0\(viewModel.currentQuestionNumber + 1)"
        } else {
            questionNumber.text = "\(viewModel.currentQuestionNumber + 1)"
        }
        
        var i = 0
        let options = question.options
        for option in options{
            optionsLabelList[i].text = option.text
            optionsLayoutList[i].alpha = 1
            if option.isCorrect{
                optionsLayoutList[i].optionStateColor = OptionStates.OptionIsCorrect
            }
            i = i+1;
        }
        
    }
    
    @objc func onQuestionBookmarked(_ sender: UITapGestureRecognizer){
        print("book marked question")
        let onMarkedQuestions = MarkedQuestions.onQuestionMarkedStateChanged(forQuestionWithId: viewModel.currentQuestion.value?.id ?? "", realm)
        switch onMarkedQuestions {
        case MarkedQuestionStates.QUESTION_MARKED:
            
            viewModel.markedQuestionSet.insert(viewModel.currentQuestion.value?.id ?? "")
            markQuestionsImage.image = UIImage(named: "bookmarked")
            break
        case MarkedQuestionStates.MARKED_QUESTION_REMOVED:
            viewModel.markedQuestionSet.remove(viewModel.currentQuestion.value?.id ?? "")
            viewModel.removeQuestionFromList(forQuestionId: viewModel.currentQuestion.value?.id ?? "")
            markQuestionsImage.image = UIImage(named: "bookmark")
            break
        case MarkedQuestionStates.ERROR:
            print("ERORR State did not change")
            break
        }
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
