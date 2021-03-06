//
//  SessionDataManager.swift
//  AV TEST AID
//
//  Created by Juan Pablo Mazza on 11/8/16.
//  Copyright © 2016 Rootstrap. All rights reserved.
//

import UIKit

class SessionManager: NSObject {

    static var currentSession: Session? {
        get {
            if let data = UserDefaults.standard.data(forKey: "AV TEST AID-session"), let session = try? JSONDecoder().decode(Session.self, from: data) {
                return session
            }
            return nil
        }

        set {
            let session = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(session, forKey: "AV TEST AID-session")
        }
    }

    class func start(session: Session) {
        currentSession = session
    }

    class func deleteSession() {
        UserDefaults.standard.removeObject(forKey: "AV TEST AID-session")
    }

    static var validSession: Bool {
        if let session = currentSession, let token = session.accessToken {
            return !token.isEmpty
        }
        return false
    }
}
