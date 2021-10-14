//
//  Questions.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 23/06/2021.
//  
//

import Foundation
import RealmSwift

class Question: Object {
    @objc dynamic var  id : String = ""
    @objc dynamic var  text: String?
    @objc dynamic var  explanation : String?
    @objc dynamic var  profession: String?
    @objc dynamic var  topic: String?
    dynamic var  options = List<Option>()
    
    convenience init(questionRest: QuestionRest) {
        self.init()
        self.id = questionRest._id
        self.text = questionRest.text
        self.explanation = questionRest.explanation
        self.profession = questionRest.profession.id
        self.topic = questionRest.topic.id
        questionRest.options.forEach { (value) in
            options.append(Option(optionsRest: value))
        }
    }
    
    required init() {
    }
    
    static func insertQuestions(questions: [Question], realm: Realm){
        try! realm.write{
            realm.add(questions, update: .modified)
        }
    }
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    @discardableResult
    static func getQuestionResults(forProfessionId professionID: String, _ realm: Realm) -> Results<Question>{
        let questions = realm.objects(Question.self).filter("profession = %@", professionID)
        return questions
    }
    
    @discardableResult
    static func getQuestionResults(_ realm: Realm) -> Results<Question>{
        let questions = realm.objects(Question.self)
        return questions
    }
    
    @discardableResult
    static func getPracticeQuestionsUnshuffled(forProfession : String, realm: Realm, count: Int = 10) -> [Question]{
        var practiceQuestions = [Question]()
        let resultsQuestion = getQuestionResults(forProfessionId: forProfession, realm)
        for i in 0 ... count {
            practiceQuestions.append(resultsQuestion[i])
        }
        
        return practiceQuestions
    }
    
    @discardableResult
    static func getPracticeQuestionsShuffled(forProfession : String, realm: Realm, count: Int = 9) -> [Question]{
        var practiceQuestions = [Question]()
        let resultsQuestion = getQuestionResults(forProfessionId: forProfession, realm).shuffled()
        print("count \(resultsQuestion.count)")
        if resultsQuestion.count <= count{
            return resultsQuestion
        } else {
            for i in 0 ... count {
                practiceQuestions.append(resultsQuestion[i])
            }
        }
        return practiceQuestions
    }
    
    @discardableResult
    static func getStudyQuestionsForProfessionShuffled(forProfession : String, realm: Realm) -> [Question]{
        return getQuestionResults(forProfessionId: forProfession, realm).shuffled()
    }
    
    @discardableResult
    static func getStudyQuestionsForProfessionUnshuffled(forProfession : String, realm: Realm) -> [Question]{
        let questionResults =  getQuestionResults(forProfessionId: forProfession, realm)
        let questions : [Question] = questionResults.toArray()
        return questions
    }
    
    @discardableResult
    static func getAllStudyQuestionsUnshuffled(realm: Realm) -> [Question]{
        let questionResults =  getQuestionResults(realm)
        let questions : [Question] = questionResults.toArray()
        return questions
    }
    
    @discardableResult
    static func getAllStudyQuestionsShuffled(realm: Realm) -> [Question]{
        return  getQuestionResults(realm).shuffled()
    }
    
    @discardableResult
    static func getQuestion(withQuestionId questionId: String, _ realm: Realm) -> Question? {
        return realm.objects(Question.self).filter("id = %@", questionId).first
    }
    
    @discardableResult
    static func getAllBookMarkedQuestion(_ realm: Realm) -> [Question] {
        let keys = MarkedQuestions.getAllMarkedQuestions(realm)
        let markedQuestions = realm.objects(Question.self).filter("id IN %@", keys)
        return markedQuestions.toArray()
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}

