//
//  Identifiers.swift
//  AV TEST AID
//
//  Created by Timileyin Ogunsola on 13/07/2021.
//  Copyright © 2021 TopTier labs. All rights reserved.
//

import Foundation

struct StringIDs {
    
    struct SegueIdentfiers {}
    
    struct StoryBoardIdentifiers {
        static let MAIN =                               "Main"
        static let DASHBOARD =                          "DashBoardStorryBoard"
    }
    
    struct PersistenceIdentifiers {
        static let PROFESSIONS =                        "professions"
        static let PROFESSION  =                        "profession"
        static let SHUFFLE_PRACTICE_QUESTION =          "shuffle_practice_question"
        static let SHUFFLE_STUDY_QUESTION =             "shuffle_study_question"
        static let SHOW_ONLY_CORRECT_QUESTION =         "show_only_correct_question"
    }
    
    struct ProfessionIdentifiers {
        static let PILOT =                              "Pilot"
        static let AIR_TRAFFIC_CONTROLLER =             "Air traffic controller"
        static let ENGINEER =                           "Engineer"
        static let FLIGHT_ATTENDANT =                   "Flight attendant"
    }
}
