//
// Created by Efe Ejemudaro on 12/04/2021.
// Copyright (c) 2021 TopTier labs. All rights reserved.
//

import Foundation
import MaterialComponents

struct Validator {

    private static let errorMessage = "This field is required"

    static func validate(textControllers: MDCTextInputControllerBase...) -> Bool {
        for textController in textControllers {
            if (textController.textInput?.text?.isEmpty ?? true) {
                textController.setErrorText(errorMessage, errorAccessibilityValue: errorMessage)
                return false
            }
        }
        return true
    }

    static func validate(textController: MDCTextInputControllerBase, minLength: Int,
                         errorMessage: String? = nil) -> Bool {
        let length = textController.textInput?.text?.count ?? 0
        if (length < minLength) {
            textController.setErrorText(errorMessage, errorAccessibilityValue: errorMessage)
            return false
        }
        return true
    }

    static func validate(textField: UITextField, minLength: Int,
                         errorMessage: String? = nil) -> Bool {
        let length = textField.text?.count ?? 0
        if (length < minLength) {
            return false
        }
        return true
    }

    static func validate(minLength: Int, errorMessage: String?, textControllers: MDCTextInputControllerBase...) -> Bool {
        for textController in textControllers {
            if !validate(textController: textController, minLength: minLength, errorMessage: errorMessage) {
                return false
            }
        }
        return true
    }

    static func clearErrors(textControllers: MDCTextInputControllerBase...) {
        for textController in textControllers {
            textController.setErrorText(nil, errorAccessibilityValue: nil)
        }
    }
}
