//
//  APIError.swift
//  AV TEST AID
//
//  Created by Mauricio Cousillas on 6/4/19.
//  Copyright © 2019 TopTier labs. All rights reserved.
//

import Foundation
import Moya

let genericErrorMessage = "An error occurred, please try again."

struct APIError: Error {
    let statusCode: Int
    let error: RailsError

    /// Returns the error message from the API
    var errorMessage: String {
        if let errorMessage = error.message {
            return errorMessage
        }
        return genericErrorMessage
    }

    // Returns an array containing all error values returned from the API
    static func from(response: Response) -> APIError? {
        guard let decodedError = try? response.map(RailsError.self) else {
            return nil
        }
        return APIError(statusCode: response.statusCode, error: decodedError)
    }
}

struct RailsError: Decodable {
    let success: Bool
    let message: String?

    enum CodingKeys: String, CodingKey {
        case success, message
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let errorMessage = try? values.decode(String.self, forKey: .message) {
            message = errorMessage
        } else {
            message = nil
        }
        if let success = try? values.decode(Bool.self, forKey: .success) {
            self.success = success
        } else {
            success = false
        }
    }
}
