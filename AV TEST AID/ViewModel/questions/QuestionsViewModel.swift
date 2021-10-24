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
    let currentQuestionSessionItem = BehaviorRelay<QuestionSessionItem?>(value: nil)
    let currentQuestion = BehaviorRelay<Question?>(value: nil)
    let onFilterApplied = BehaviorRelay(value: false)
    var currentQuestionNumber = -1
    var currentQuestionList : [Question] = []
    var filteredQuestionList : [Question] = []
    var currentSessionQuestionList: [QuestionSessionItem] = []
    var currentQuestionSession : QuestionSession? = nil
    var totalQuestions = 0;
    var totalQuestionsFiltered = 0;
    var questionIdOptionChosenIdDictionary: [String : String] = [:]
    var markedQuestionSet : Set<String> = []
    var studyQuestionsTopics : Set<String> = []
    var topics = BehaviorRelay<[String]>(value: [])
    
    
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
            self.currentQuestionSessionItem.accept(currentQuestionSession.0)
        } else {
            guard let currentQuestionSession = QuestionSession.getCurrentQuestionAndStateForSession(realm) else {return}
            markedQuestionSet = MarkedQuestions.getAllMarkedQuestionsAsSet(realm)
            totalQuestions = currentQuestionSession.2
            currentQuestionNumber = currentQuestionSession.1
            resetOptionsSelectedIntoDictionary(optionsSelected: currentQuestionSession.3)
            self.currentQuestionSessionItem.accept(currentQuestionSession.0)
        }
    }
    
    func setupStudyQuestions(realm: Realm, id: String){
        markedQuestionSet = MarkedQuestions.getAllMarkedQuestionsAsSet(realm)
        if(LocalStorage.shared.getBoolean(key: StringIDs.PersistenceIdentifiers.SHUFFLE_STUDY_QUESTION) ?? false){
            currentQuestionList = Question.getStudyQuestionsForProfessionShuffled(forProfession: id, realm: realm)
        } else {
            currentQuestionList = Question.getStudyQuestionsForProfessionUnshuffled(forProfession: id, realm: realm)
        }
        
        filteredQuestionList = currentQuestionList;
        totalQuestions = currentQuestionList.count;
        totalQuestionsFiltered = filteredQuestionList.count;
        getAllUniqueTopics(questions: currentQuestionList)
        moveToNextQuestionStudySession()
       
    }
    
    func moveToNextQuestionStudySession(){
        if(currentQuestionNumber < totalQuestionsFiltered - 1){
            currentQuestionNumber =  currentQuestionNumber + 1
            print("current question number view model \(currentQuestionNumber)")
            self.currentQuestion.accept(filteredQuestionList[currentQuestionNumber])
        }
    }
    
    func moveToPrevQuestionStudySession(){
        if(currentQuestionNumber > 0){
            currentQuestionNumber =  currentQuestionNumber - 1;
            self.currentQuestion.accept(filteredQuestionList[currentQuestionNumber])
        }
    }
    
    func getAllUniqueTopics(questions: [Question]){
        for question in questions {
            if let topic = question.topicString{
                studyQuestionsTopics.insert(topic)
            }
        }
        var studyQuestionsList : [String] = []
        studyQuestionsList.append("All")
        studyQuestionsList.append(contentsOf: studyQuestionsTopics.map{$0})
        
        topics.accept(studyQuestionsList)
    }
    
    
    func moveToNextQuestionPracticeSession(_ realm: Realm){
        if(currentQuestionNumber < totalQuestions - 1){
            let currentQuestionInSession = QuestionSession.getCurrentQuestionForSessionOnNext(realm)
            currentQuestionNumber = currentQuestionInSession!.1
            
            self.currentQuestionSessionItem.accept(currentQuestionInSession?.0)
        }
    }
    
    func moveToPreviousQuestionPracticeSession(_ realm: Realm){
        if(currentQuestionNumber > 0){
            let currentQuestionInSession = QuestionSession.getCurrentQuestionForSessionOnPrev(realm)
            currentQuestionNumber = currentQuestionInSession!.1
            self.currentQuestionSessionItem.accept(currentQuestionInSession?.0)
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
    
    func onNewTopicSelected(topic: String){
        if topic != "All" {
            filteredQuestionList = currentQuestionList.filter { $0.topicString == topic }
        } else {
            filteredQuestionList = currentQuestionList
        }
        
        totalQuestionsFiltered = filteredQuestionList.count
        currentQuestionNumber = -1
        moveToNextQuestionStudySession()
        onFilterApplied.accept(true)
    }
}


