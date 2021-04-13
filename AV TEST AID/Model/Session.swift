//
//  Session.swift
//  AV TEST AID
//
//  Created by Juan Pablo Mazza on 11/8/16.
//  Copyright © 2016 Rootstrap. All rights reserved.
//

import Foundation

struct Session: Codable {

    var accessToken: String?

    private enum CodingKeys: String, CodingKey {
        case accessToken = "token"
    }

}
