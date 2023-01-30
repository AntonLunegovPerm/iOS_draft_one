//
//  UIViewController.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import UIKit

extension UIViewController {
    func showAlertAccept(title: String,
                   text: String,
                   okTitle: String,
                   cancelTitle: String,
                   okMethod: @escaping () -> Void,
                   cancelMethod: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: okTitle, style: .default, handler: { _ in okMethod() })
        let actionCancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: { _ in cancelMethod() })
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        self.present(alert, animated: true)
    }
    
    func showAlertError(text: String) {
        let alert = UIAlertController(title: "Упс, ошибка ...", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func dismissToLeft() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    func presentToRight(vc: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.35
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.present(vc, animated: false, completion: nil)
    }
    
    class func instanceView(storyboard: String, viewIdentifier: String) -> Self {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier) as! Self
    }

    class func instanceView() -> Self {
        let name = String(describing: self)
        return instanceView(storyboard: name, viewIdentifier: name)
    }
    
}
