//
//  AppNavigator.swift
//  AV TEST AID
//
//  Created by Mauricio Cousillas on 6/13/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation

class AppNavigator: BaseNavigator {
    static let shared = AppNavigator()

    init() {
//        let initialRoute: Route = SessionManager.validSession ?
//                HomeRoutes.home : OnboardingRoutes.firstScreen
        super.init(with: OnboardingRoutes.firstScreen)
    }

    required init(with route: Route) {
        super.init(with: route)
    }
}
