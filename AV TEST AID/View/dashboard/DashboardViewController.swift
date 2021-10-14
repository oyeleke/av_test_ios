//
//  DashboardViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 05/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import MaterialComponents
import DropDown
import RealmSwift


class DashboardViewController: BaseViewController {
    
    @IBOutlet weak var searchTextField: MDCTextField!
    @IBOutlet weak var knowledgeScoreView: CustomDesignableView!
    @IBOutlet weak var markedQuestionsView: CustomDesignableView!
    @IBOutlet weak var practiceQuestionView: CustomDesignableView!
    @IBOutlet weak var studyQuestionView: CustomDesignableView!
    private var searchController: OutlinedTextInputController!
    var viewModel:  QuestionsViewModel!
    var realm: Realm!
    
    override func viewDidLoad() {
        viewModel = QuestionsViewModel()
        super.viewDidLoad()
        realm = try! Realm()
        viewModel.getQuestionsFromApi(realm)
        bindViewModel()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    private func setupView(){
        searchController = OutlinedTextInputController(textInput: searchTextField)
        setupSearchButton()
        knowledgeScoreView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToKnowledgeScore(_:))))
        markedQuestionsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToMarkedQuestions(_:))))
        practiceQuestionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToPracticeQuestions(_:))))
        studyQuestionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(moveToStudyQuestions)))
        MarkedQuestions.createMarkedQuestionsInRealmIfitDoesNotExist(realm)
    }
    
    private func bindViewModel(){
        viewModel.getQuestionsState.subscribe(onNext: {questionState in
            if(questionState){
                self.viewModel.getProfession()
            }
        }).disposed(by: disposeBag)
    }
    
    override func getViewModel() -> BaseViewModel {
        viewModel
    }
    
    // MARK: - Navigation
    
    
    @IBAction func refresh(_ sender: Any) {
        print("refreshing ur ass bro")
    }
    
    func setupSearchButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "mic.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(300), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        searchTextField.rightView = button
        searchTextField.rightViewMode = .always
    }
    
    @objc func moveToKnowledgeScore(_ sender: UITapGestureRecognizer){
        if #available(iOS 13.0, *) {
            guard let knowledgeScoreViewController = UIStoryboard.instantiateViewController(KnowledgeScoreViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
                return
            }
            knowledgeScoreViewController.viewModel = KnowledgeScoreViewModel()
            navigationController?.pushViewController(knowledgeScoreViewController, animated: true)
        } else {
            print("earlier version not avialable")
        }
        
    }
    
    @objc func moveToMarkedQuestions(_ sender: UITapGestureRecognizer){
        guard let markedQuestionsViewController = UIStoryboard.instantiateViewController(MarkedQuestionsViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        markedQuestionsViewController.viewModel = MarkedQuestionsViewModel()
        navigationController?.pushViewController(markedQuestionsViewController, animated: true)
    }
    
    @objc func moveToPracticeQuestions(_ sender: UITapGestureRecognizer){
        guard let viewController = UIStoryboard.instantiateViewController(ProfessionBottomSheetViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: viewController)
        bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height:  self.view.frame.size.height * 0.5)
        viewController.delegate = self
        present(bottomSheet, animated: true, completion: nil)
    }
    
    @objc func moveToStudyQuestions(_ sender: UITapGestureRecognizer){
        
    }
}

extension DashboardViewController : OnProfessionSelected {
    
    func moveToPracticeQuestion(profession: Profession) {
        print("practice question clicked.....")
        guard let practiceQuestionViewController = UIStoryboard.instantiateViewController(PracticeQuestionViewController.self, storyboardIdentifier: "DashBoardStorryBoard") else {
            return
        }
        print("Settings arrow passed.....")
        practiceQuestionViewController.profession = profession
        practiceQuestionViewController.viewModel = QuestionsViewModel()
        navigationController?.pushViewController(practiceQuestionViewController, animated: true)
    }
}
