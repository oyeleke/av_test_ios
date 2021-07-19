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
}
