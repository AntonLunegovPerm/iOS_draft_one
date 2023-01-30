//
//  SwitchBuilderType.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

protocol SwitchBuilderType: UIBuilderType {
    func useAutoLayout() -> Self
    func setIsOn(_ isOn: Bool) -> Self
    func setOnTintColor(_ color: UIColor?) -> Self
    func setThumbTintColor(_ color: UIColor?) -> Self
    func addTarget(_ target: Any, action: Selector, for event: UIControl.Event) -> Self
}
