//
//  ProfessionBottomSheetViewController.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 08/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import MaterialComponents

class ProfessionBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var pilotUIView: UIView!
    @IBOutlet weak var flightAttendantView: UIView!
    @IBOutlet weak var airTrafficControllerView: UIView!
    @IBOutlet weak var engineerView: UIView!
    var questionViewModel : QuestionsViewModel!
    var realm : Realm!
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        setupViews()
    }
    
    private func setupViews(){
        pilotUIView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPilotViewClicked(_:))))
        flightAttendantView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onFlightAttendantViewClicked(_:))))
        airTrafficControllerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onAirTrafficViewClicked(_:))))
        engineerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onEngineerViewClicked(_:))))
    }
    
    
    @objc func onPilotViewClicked(_ sender: UITapGestureRecognizer) {
        let professions = LocalStorage.shared.getProfessions()
        let pilot = professions.first { (profession) -> Bool in
            profession.name == StringIDs.ProfessionIdentifiers.PILOT
        }
        let questions = Question.getPracticeQuestionsShuffled(forProfession : pilot?.id ?? "", realm: realm)
        
        print("\(questions)")
     }
    
    @objc func onFlightAttendantViewClicked(_ sender: UITapGestureRecognizer) {
         let professions = LocalStorage.shared.getProfessions()
               let pilot = professions.first { (profession) -> Bool in
                   profession.name == StringIDs.ProfessionIdentifiers.FLIGHT_ATTENDANT
               }
               let questions = Question.getPracticeQuestionsShuffled(forProfession : pilot?.id ?? "", realm: realm)
               
               print("\(questions)")
            
      }
    
    @objc func onAirTrafficViewClicked(_ sender: UITapGestureRecognizer) {
         let professions = LocalStorage.shared.getProfessions()
               let pilot = professions.first { (profession) -> Bool in
                   profession.name == StringIDs.ProfessionIdentifiers.AIR_TRAFFIC_CONTROLLER
               }
               let questions = Question.getPracticeQuestionsShuffled(forProfession : pilot?.id ?? "", realm: realm)
               
               print("\(questions)")
            
      }
    
    @objc func onEngineerViewClicked(_ sender: UITapGestureRecognizer) {
         let professions = LocalStorage.shared.getProfessions()
               let pilot = professions.first { (profession) -> Bool in
                   profession.name == StringIDs.ProfessionIdentifiers.ENGINEER
               }
               let questions = Question.getPracticeQuestionsShuffled(forProfession : pilot?.id ?? "", realm: realm)
               
               print("\(questions)")
            
      }
}
