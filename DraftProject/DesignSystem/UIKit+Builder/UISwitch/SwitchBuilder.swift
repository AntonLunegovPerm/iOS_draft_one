//
//  SwitchBuilder.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

class SwitchBuilder: SwitchBuilderType {
    
    private var switchView: UISwitch
    
    init(_ switchView: UISwitch = UISwitch()) {
        self.switchView = switchView
    }
    
    // MARK: - UIBuilderType
    class func startBuild() -> Self {
        SwitchBuilder() as! Self
    }
    
    func build() -> UISwitch {
        switchView
    }
    
    // MARK: - SwitchBuilderType
    func useAutoLayout() -> Self {
        switchView.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    func setIsOn(_ isOn: Bool) -> Self {
        switchView.isOn = isOn
        return self
    }
    
    func setOnTintColor(_ color: UIColor?) -> Self {
        switchView.onTintColor = color
        return self
    }
    
    func setThumbTintColor(_ color: UIColor?) -> Self {
        switchView.thumbTintColor = color
        return self
    }
    
    func addTarget(_ target: Any, action: Selector, for event: UIControl.Event) -> Self {
        switchView.addTarget(target, action: action, for: event)
        return self
    }
}
