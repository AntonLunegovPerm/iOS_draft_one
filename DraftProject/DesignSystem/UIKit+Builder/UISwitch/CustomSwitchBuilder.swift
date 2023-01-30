//
//  CustomSwitchBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class CustomSwitchBuilder: SwitchBuilder {
    
    private var cSwitch: CustomSwitch
    
    init(_ cSwitch: CustomSwitch = CustomSwitch()) {
        self.cSwitch = cSwitch
        super.init(cSwitch)
    }
    
    override class func startBuild() -> Self {
        CustomSwitchBuilder() as! Self
    }
    
    override func build() -> CustomSwitch {
        cSwitch
    }
}
