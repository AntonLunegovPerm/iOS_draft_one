//
//  MapTextPinDrawer.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import UIKit

class MapTextPinDrawer {
    
    var font = R.font.robotoMedium(size: 14)! {
        didSet {
            clearCache()
        }
    }
    
    var textColor = R.color.neutral0()! {
        didSet {
            clearCache()
        }
    }
    
    var bubbleColorNormal = R.color.mainColor()! {
        didSet {
            clearCache()
        }
    }
    
    var bubbleColorSelected = R.color.accent()! {
        didSet {
            clearCache()
        }
    }
    
    var edgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6) {
        didSet {
            clearCache()
        }
    }
    
    var arrowSize = CGSize(width: 10, height: 5) {
        didSet {
            clearCache()
        }
    }
    
    var cornerRadius: CGFloat = 8 {
        didSet {
            clearCache()
        }
    }
    
    private class CacheItem {
        var normal: UIImage?
        var selected: UIImage?
    }
    private var cache = [String: CacheItem]()
    
    func drawWith(text: String, isSelected: Bool) -> UIImage {
        if let image = getPinFromCache(text: text, isSelected: isSelected) {
            return image
        }
        
        let text = text as NSString
        let textSize = getSizeFor(text: text)
        let bubbleSize = CGSize(width: textSize.width + edgeInsets.left + edgeInsets.right,
                          height: textSize.height + edgeInsets.top + edgeInsets.bottom)
        let imageSize = CGSize(width: bubbleSize.width, height: bubbleSize.height + arrowSize.height)
        let bubbleColor = isSelected ? bubbleColorSelected : bubbleColorNormal
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(bubbleColor.cgColor)
        
        let path = CGMutablePath()
        
        path.addRoundedRect(in: CGRect(origin: .zero, size: bubbleSize), cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        
        path.move(to: CGPoint(x: (bubbleSize.width - arrowSize.width)/2, y: bubbleSize.height))
        path.addLine(to: CGPoint(x: bubbleSize.width/2, y: bubbleSize.height + arrowSize.height))
        path.addLine(to: CGPoint(x: (bubbleSize.width + arrowSize.width)/2, y: bubbleSize.height))
        path.closeSubpath()
        
        ctx?.addPath(path)
        ctx?.fillPath()
        
        text.draw(at: CGPoint(x: edgeInsets.left, y: edgeInsets.top),
                  withAttributes: [.font: font, .foregroundColor: textColor])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        image.flatMap { addPinToCache(image: $0, text: text as String, isSelected: isSelected) }
        
        return image ?? UIImage()
    }
    
    private func getSizeFor(text: NSString) -> CGSize {
        let lineHeight = font.lineHeight
        let limits = CGSize(width: .greatestFiniteMagnitude, height: lineHeight)
        return text.boundingRect(with: limits,
                                               options: [.usesLineFragmentOrigin, .usesFontLeading],
                                               attributes: [.font: font], context: nil)
            .size
    }
}

extension MapTextPinDrawer {
    private func addPinToCache(image: UIImage, text: String, isSelected: Bool) {
        var item = cache[text]
        if item == nil {
            item = CacheItem()
            cache[text] = item
        }
        
        if isSelected {
            item?.selected = image
        }
        else {
            item?.normal = image
        }
    }
    
    private func getPinFromCache(text: String, isSelected: Bool) -> UIImage? {
        let item = cache[text]
        return isSelected ? item?.selected : item?.normal
    }
    
    private func clearCache() {
        cache.removeAll()
    }
}

