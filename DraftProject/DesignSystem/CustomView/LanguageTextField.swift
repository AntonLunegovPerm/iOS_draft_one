//
//  LanguageTextField.swift
//  DraftProject
//
//  Created by LAV on 29.01.2023.
//

import UIKit

final class LanguageTextField: CustomTextField {
    var languageCode:String?{
        didSet{
            if self.isFirstResponder{
                self.resignFirstResponder();
                self.becomeFirstResponder();
            }
        }
    }

    override var textInputMode: UITextInputMode?{
        if let language_code = self.languageCode{
            for keyboard in UITextInputMode.activeInputModes{
                if let language = keyboard.primaryLanguage{
                    let locale = Locale.init(identifier: language);
                    if locale.languageCode == language_code{
                        return keyboard;
                    }
                }
            }
        }
        return super.textInputMode;
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        
        return originalRect.offsetBy(dx: -8, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.textRect(forBounds: bounds)
        
        return CGRect(origin: originalRect.origin,
                      size: CGSize(width: originalRect.width - 8,
                                   height: originalRect.height))
    }
}

