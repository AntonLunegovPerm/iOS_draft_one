//
//  UIView.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import UIKit

//AutoLayout
extension UIView {
    @objc var rotationDegrees: CGFloat {
        get {
            let angle = atan2(transform.b, transform.a);
            return angle * (180 / CGFloat.pi)
        }
        set {
            transform = CGAffineTransform(rotationAngle: newValue * CGFloat.pi / 180)
        }
    }
    
    func setBackgroundColorRecursively(_ color: UIColor?) {
        backgroundColor = color
        for subview in subviews {
            subview.setBackgroundColorRecursively(color)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let layerBorderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: layerBorderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let layerShadowColor = layer.shadowColor else {
                return nil
            }
            return UIColor(cgColor: layerShadowColor)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @available(iOS 11, *)
    var maskedCorners: CACornerMask {
        get {
            self.layer.maskedCorners
        }
        set {
            self.layer.maskedCorners = newValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
    }

    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}


//In Code
extension UIView {
    
    public static func get<T:UIView>(type: T.Type) -> T {
        let name = String(describing: type)
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    enum ConstraintsAlignment {
        case none
        case stretch
        case horizontalStretch
        case verticalStretch
        case topStretch
        case stretchOffset(_ attribute: NSLayoutConstraint.Attribute, _ offset: CGFloat)
        case stretchAllOffset(_ offset: CGFloat)
        case center
        case centerBottom
        case horizontalCenter(_ offset: CGFloat)
        case baseline(_ offset: CGFloat, _ marginOffset: CGFloat)
        
        var attributes: [NSLayoutConstraint.AttributeOffset] {
            switch self {
            case .none:
                return []
            case .stretch:
                return [.init(.top), .init(.right), .init(.bottom), .init(.left)]
            case .horizontalStretch:
                return [.init(.right), .init(.left)]
            case .verticalStretch:
                return [.init(.top), .init(.bottom)]
            case .topStretch:
                return [.init(.top), .init(.right), .init(.left)]
            case .stretchOffset(let attribute, let offset):
                var attrs = [NSLayoutConstraint.AttributeOffset(attribute, offset: offset)]
                
                [NSLayoutConstraint.Attribute.top, .right, .bottom, .left].forEach { attr in
                    if attr != attribute {
                        attrs.append(.init(attr, offset: 0))
                    }
                }
                
                return attrs
            case .stretchAllOffset(let offset):
                return [.init(.top, offset: offset), .init(.left, offset: offset), .init(.bottom, offset: 0 - offset), .init(.right, offset: 0 - offset)]
            case .center:
                return [.init(.centerX), .init(.centerY)]
            case .centerBottom:
                return [.init(.centerX), .init(.bottom)]
            case .horizontalCenter(let offset):
                return [.init(.left, offset: offset), .init(.right, offset: 0 - offset), .init(.centerY)]
            case .baseline(let offset, let marginOffset):
                return [.init(.left, offset: marginOffset), .init(.right, offset: 0 - marginOffset), .init(.firstBaseline, offset: offset)]
            }
        }
    }
    
    func addToView(_ view: UIView, constraintsToView: UIView? = nil, alignment: ConstraintsAlignment = .stretch) {
        view.addSubview(self)
        addConstraints(to: constraintsToView ?? view, alignment: alignment)
    }
    
    func addHiddenToView(_ view: UIView, constraintsToView: UIView? = nil, alignment: ConstraintsAlignment = .stretch) {
        addToView(view, constraintsToView: constraintsToView, alignment: alignment)
        isHidden = true
    }
    
    func stretch(to view: UIView) {
        addConstraints(to: view, alignment: .stretch)
    }
    
    func addConstraints(to view: UIView, viewContainer: UIView? = nil, alignment: ConstraintsAlignment) {
        addConstraints(to: view, viewContainer: viewContainer, alignment.attributes)
    }
    
    func addConstraints(to view: UIView, viewContainer: UIView? = nil, _ attributes: [NSLayoutConstraint.AttributeOffset]) {
        translatesAutoresizingMaskIntoConstraints = false
        
        (viewContainer ?? view).addConstraints(attributes.map({
            NSLayoutConstraint(item: self, attribute: $0.attribute, relatedBy: .equal, toItem: view, attribute: $0.attribute, multiplier: 1, constant: $0.offset)
        }))
    }
    
    func addConstraint(_ attribute: NSLayoutConstraint.Attribute, constant: CGFloat) {
        addConstraint(NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: constant))
    }
    
    func hasInSuperview(_ views: [UIView]) -> Bool {
        var v = superview
        while v != nil {
            if views.contains(v!) {
                return true
            }
            v = v?.superview
        }
        return false
    }
    
    static func loadViewFromNib<T: UIView>() -> T? {
        let name = T.description().components(separatedBy: ".").last!
        
        guard Bundle.main.path(forResource: name, ofType: "nib") != nil else {
            return nil
        }
        
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
    }
    
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }

        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }

        return nil
    }
    
    func sendToBack(in superView: UIView) {
        superView.sendSubviewToBack(self)
    }
}

extension NSLayoutConstraint {
    
    class AttributeOffset {
        var attribute: Attribute
        var offset: CGFloat = 0
        
        init(_ attribute: Attribute, offset: CGFloat = 0) {
            self.attribute = attribute
            self.offset = offset
        }
    }
    
    static func setMultiplier(_ multiplier: CGFloat, of constraint: inout NSLayoutConstraint) {
        if let item = constraint.firstItem {
            NSLayoutConstraint.deactivate([constraint])

            let newConstraint = NSLayoutConstraint(item: item, attribute: constraint.firstAttribute, relatedBy: constraint.relation, toItem: constraint.secondItem, attribute: constraint.secondAttribute, multiplier: multiplier, constant: constraint.constant)

            newConstraint.priority = constraint.priority
            newConstraint.shouldBeArchived = constraint.shouldBeArchived
            newConstraint.identifier = constraint.identifier

            NSLayoutConstraint.activate([newConstraint])
            constraint = newConstraint
        }
    }
}
