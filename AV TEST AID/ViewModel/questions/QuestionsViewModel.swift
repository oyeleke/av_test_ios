//
//  QuestionsViewModel.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 26/06/2021.
//  
//

import Foundation

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class QuestionsViewModel : BaseViewModel {
    
    let getQuestionsState = BehaviorRelay(value: false)
    let currentQuestion = BehaviorRelay<QuestionSessionItem?>(value: nil)
    var currentQuestionNumber = -1
    var currentQuestionList : [Question] = []
    var currentSessionQuestionList: [QuestionSessionItem] = []
    var currentQuestionSession : QuestionSession? = nil
    var totalQuestions = 0;
    var questionIdOptionChosenIdDictionary: [String : String] = [:]
    var markedQuestionSet : Set<String> = []
    
    
    func getQuestionsFromApi(_ realm: Realm){
        state.accept(.loading("Initializing"))
        AVTestService.sharedInstance.fetchQuestions()
            .subscribe( onNext: { (questions) in
                var questionData : [Question] = []
                for question in questions{
                    questionData.append(Question(questionRest: question))
                }
                Question.insertQuestions(questions: questionData, realm: realm)
                self.getQuestionsState.accept(true)
                self.state.accept(.idle)
            }, onError:  { [weak self] error in
                if let apiError = error as? APIError{
                    print("\(apiError)")
                    self?.state.accept(.error(apiError.errorMessage))
                } else {
                    print("\(error)")
                    self?.state.accept(.error(error.localizedDescription))
                }
            }).disposed(by: disposeBag)
    }
    
    func getProfession(){
        state.accept(.loading("Initializing"))
        AVTestService.sharedInstance.fetchProfessions().subscribe( onNext: { (professions) in
            LocalStorage.shared.delete(key: StringIDs.PersistenceIdentifiers.PROFESSIONS)
            LocalStorage.shared.persistProfessions(profession: professions)
            self.state.accept(.idle)
        }, onError:  { [weak self] error in
            if let apiError = error as? APIError{
                print("\(apiError)")
                self?.state.accept(.error(apiError.errorMessage))
            } else {
                print("\(error)")
                self?.state.accept(.error(error.localizedDescription))
            }
        }).disposed(by: disposeBag)
    }
    
    //
    func setUpPracticeQuestions(realm: Realm, id: String){
        //TODO do check to ensure there is no practice question in session
        currentQuestionSession = QuestionSession.getQuestionSession(realm)
        if(currentQuestionSession == nil){
            if(LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHUFFLE_PRACTICE_QUESTION) ?? false){
                currentQuestionList = Question.getPracticeQuestionsShuffled(forProfession : id, realm: realm)
            } else {
                currentQuestionList = Question.getPracticeQuestionsUnshuffled(forProfession: id, realm: realm)
            }
            markedQuestionSet = MarkedQuestions.getAllMarkedQuestionsAsSet(realm)
            print("current question list \(currentQuestionList)")
            let questionSession = QuestionSession(questions: currentQuestionList)
            QuestionSession.insertQuestionSession(questionSession: questionSession, realm: realm)
            guard let currentQuestionSession = QuestionSession.getCurrentQuestionAndStateForSession(realm) else {return}
            totalQuestions = currentQuestionSession.2
            currentQuestionNumber = currentQuestionSession.1
            self.currentQuestion.accept(currentQuestionSession.0)
        } else {
            guard let currentQuestionSession = QuestionSession.getCurrentQuestionAndStateForSession(realm) else {return}
            markedQuestionSet = MarkedQuestions.getAllMarkedQuestionsAsSet(realm)
            totalQuestions = currentQuestionSession.2
            currentQuestionNumber = currentQuestionSession.1
            resetOptionsSelectedIntoDictionary(optionsSelected: currentQuestionSession.3)
            self.currentQuestion.accept(currentQuestionSession.0)
        }
    }
    
    
    func moveToNextQuestion(_ realm: Realm){
        if(currentQuestionNumber < totalQuestions - 1){
            let currentQuestionInSession = QuestionSession.getCurrentQuestionForSessionOnNext(realm)
            currentQuestionNumber = currentQuestionInSession!.1
            
            self.currentQuestion.accept(currentQuestionInSession?.0)
        }
    }
    
    func moveToPreviousQuestion(_ realm: Realm){
        if(currentQuestionNumber > 0){
            let currentQuestionInSession = QuestionSession.getCurrentQuestionForSessionOnPrev(realm)
            currentQuestionNumber = currentQuestionInSession!.1
            self.currentQuestion.accept(currentQuestionInSession?.0)
        }
    }
    
    func onOptionChosen(forQuestionId: String, option: Option, realm: Realm){
        questionIdOptionChosenIdDictionary[forQuestionId] = option.id
        QuestionSession.onOptionSelected(forQuestionId: forQuestionId, option: option, realm)
    }
    
    func resetOptionsSelectedIntoDictionary(optionsSelected: [OptionsSelected]){
        for optionSelected in optionsSelected {
            questionIdOptionChosenIdDictionary[optionSelected.id] = optionSelected.optionId
        }
    }
    
    func resetQuestionSession(_ realm: Realm){
        QuestionSession.resetSession(realm)
        questionIdOptionChosenIdDictionary.removeAll()
    }
}


