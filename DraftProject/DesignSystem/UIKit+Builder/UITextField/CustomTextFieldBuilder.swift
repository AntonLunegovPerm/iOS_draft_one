//
//  CustomTextFieldBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class CustomTextFieldBuilder: TextFieldBuilder {
    
    private var textField: CustomTextField
    
    init(_ textField: CustomTextField = CustomTextField()) {
        self.textField = textField
        super.init(textField)
    }
    
    override class func startBuild() -> Self {
        CustomTextFieldBuilder() as! Self
    }
    
    override func build() -> CustomTextField {
        textField
    }
}
