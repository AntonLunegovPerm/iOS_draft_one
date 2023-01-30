//
//  UIImage.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import UIKit

public extension UIImage {
    
    static func origImg(_ name: String?) -> UIImage? {
        img(name)?.withRenderingMode(.alwaysOriginal)
    }
    static func tempImg(_ name: String) -> UIImage? {
        img(name)?.withRenderingMode(.alwaysTemplate)
    }
    static func img(_ name: String?) -> UIImage? {
        guard let name = name else { return nil }
        return UIImage(named: name)
    }
    
    static func tileImg(_ name: String) -> UIImage? {
        guard let image = origImg(name) else { return nil}
        return image.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: UIImage.ResizingMode.tile)
    }
    
    static func stretchImg(_ name: String, insets: UIEdgeInsets, isOrig: Bool = true) -> UIImage? {
        guard let image = isOrig ? origImg(name) : tempImg(name) else { return nil}
        return image.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
    }
    
    static func sizableImg(_ name: String, width: CGFloat) -> UIImage? {
        if let img = origImg("\(name)-\(width)") {
            return img
        }
        
        let defImg = origImg(name)
        
        let widths: [CGFloat] = [414, 375, 320]
        
        for widthSize in widths {
            if width >= widthSize {
                if defImg?.size.width ?? 0 >= widthSize {
                    return defImg
                }
                if let img = origImg("\(name)-\(widthSize)") { return img }
            }
        }
        
        if let minImg = widths.reversed().compactFirst(where: { origImg("\(name)-\($0)") }) {
            let minDiff = minImg.size.width - width
            if minDiff > 0, minDiff < defImg?.size.width ?? 0 - width {
                return minImg
            }
        }
        
        return defImg
    }
    
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    
    func image(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(x: 0.0,
                          y: 0.0,
                          width: size.width,
                          height: size.height)
        tintColor.set()
        UIRectFill(rect)
        let point = CGPoint(x: 0.0, y: 0.0)
        draw(at: point,
             blendMode: CGBlendMode.destinationIn,
             alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

