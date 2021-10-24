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
import DropDown

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
    @IBOutlet weak var dropDownAnchor: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    var mCurrentQuestion: Question!
    var optionTextList : [UILabel]!
    var optionsContainerList: [CustomOptionView]!
    private var dropDown: DropDown!
    var profession : Profession!
    
    var realm: Realm!
    var viewModel : QuestionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        setupViews()
        subscribeObservers()
        viewModel.setupStudyQuestions(realm: realm, id: profession.id)
        totalQuestionNumberLabel.text = "\(viewModel.totalQuestionsFiltered)"
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
        viewModel.moveToPrevQuestionStudySession()
    }
    
    @IBAction func onNextButtonClicked(_ sender: Any) {
        viewModel.moveToNextQuestionStudySession()
    }
    
    override func getViewModel() -> BaseViewModel {
        return viewModel
    }
    
    func setupViews(){
        contentViewHeight.constant = 200
        topicLabel.text = "All"
        optionTextList = [option1Label, option2Label, option3Label, option4Label]
        optionsContainerList = [option1Layout, option2Layout, option3Layout, option4Layout]
        option1Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped0(_:))))
        option2Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped1(_:))))
        option3Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped2(_:))))
        option4Layout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOptionTapped3(_:))))
        markQuestionsImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onQuestionBookmarked(_:))))
        initDropdown()
    }
    
    func subscribeObservers(){
        viewModel.topics.subscribe(onNext: {topics in
             print("topics \(topics)")
            self.setDropDownData(topics)
        })
        
        viewModel.currentQuestion.subscribe(onNext: {question in
            if let question = question {
                self.mCurrentQuestion = question
                self.updateQuestion(question: question)
            }else {return}
        })
        
        viewModel.onFilterApplied.subscribe(onNext: {filterApplied in
            if(filterApplied){
                self.totalQuestionNumberLabel.text = "\(self.viewModel.totalQuestionsFiltered)"
                
            }
        })
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
    
    private func updateQuestion(question: Question){
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
        
        if  viewModel.markedQuestionSet.contains(question.id ){
            markQuestionsImage.image = UIImage(named: "bookmarked")
        }
        
        questionTextLabel.text = question.text
        
        print("current question number viewModel \(viewModel.currentQuestionNumber)")
        let currentQuestionText = viewModel.currentQuestionNumber + 1
        if(currentQuestionText < 10){
            currentQuestionNumberLabel.text = "0\(currentQuestionText)"
        } else {
            currentQuestionNumberLabel.text = "\(currentQuestionText)"
        }
        
        var i = 0;
        
        
        for option in question.options{
            optionTextList[i].text = option.text
            optionsContainerList[i].alpha = 1
            if option.isCorrect {
                optionsContainerList[i].optionStateColor = OptionStates.OptionIsCorrect
            }
            i = i+1;
        }
        
        
        
    }
    
    //MARK: - Gesture Recognizer
    
    @objc func onQuestionBookmarked(_ sender: UITapGestureRecognizer){
        print("book marked question")
        let onMarkedQuestions = MarkedQuestions.onQuestionMarkedStateChanged(forQuestionWithId: mCurrentQuestion.id, realm)
        switch onMarkedQuestions {
        case MarkedQuestionStates.QUESTION_MARKED:
            viewModel.markedQuestionSet.insert(mCurrentQuestion.id )
            markQuestionsImage.image = UIImage(named: "bookmarked")
            break
        case MarkedQuestionStates.MARKED_QUESTION_REMOVED:
            viewModel.markedQuestionSet.remove(mCurrentQuestion.id)
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
    
    //MARK: - Drop Down
    
    private func initDropdown() {
        dropDown = DropDown()
        dropDown.anchorView = dropDownAnchor
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.viewModel.onNewTopicSelected(topic: item)
            self.topicLabel?.text = item
        }
        
        filterUILabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(_:))))
        styleDropDown()
    }
    
    private func styleDropDown() {
        DropDown.appearance().textColor = UIColor(named: "darkBlueTextColor")!
        DropDown.appearance().selectedTextColor = UIColor(named: "aviBlue")!
        DropDown.appearance().textFont = UIFont(name: "Quicksand-SemiBold", size: CGFloat(17))!
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.white
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        print("view tapped ===== ")
        dropDown.show()
    }
    
    func setLabelView(label labelView: UILabel) {
        
        topicLabel = labelView
    }
    
    func setDropDownData(_ options: [String]) {
        print("drop down data \(options)")
        dropDown.dataSource = options
    }
    
    func getSelectedItem() -> String? {
        dropDown.selectedItem
    }
    
    func getSelectedIndex() -> Int? {
        dropDown.indexForSelectedRow
    }
    
}

//extension StudyQuestionsViewController : UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return viewModel.studyQuestionsTopics.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {}
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {}
//}
