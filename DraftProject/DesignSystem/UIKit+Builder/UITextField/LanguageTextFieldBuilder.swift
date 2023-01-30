//
//  LanguageTextFieldBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class LanguageTextFieldBuilder: TextFieldBuilder {
    
    private var languageTextField: LanguageTextField
    
    init(_ languageTextField: LanguageTextField = LanguageTextField()) {
        self.languageTextField = languageTextField
        super.init(languageTextField)
    }
    
    override class func startBuild() -> Self {
        LanguageTextFieldBuilder() as! Self
    }
    
    override func build() -> LanguageTextField {
        return languageTextField
    }
}
