//
//  String.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import UIKit

extension String {
    var firstLetterCapitalized: String {
        prefix(1).capitalized + dropFirst()
    }
    
    func percentEscapedForURLQuery() -> String {
        addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    func digitOnlyString() -> String {
        if let regex = try? NSRegularExpression(pattern: "\\D",
                                                options: [NSRegularExpression.Options.caseInsensitive]) {
            let range = NSRange(location: 0, length: self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        }
        return ""
    }
    
    var onlyDigints: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,16}";
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func isValidURL() -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
}

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
    
    var intValue: Int? {
        Int(self)
    }
    
    func trimmingWhitespacesAndNewlines() -> String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func trimmingForHashtag() -> String {
        let charset = CharacterSet(charactersIn: "# \n")
        return trimmingCharacters(in: charset)
    }
}

extension String {
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true) else { return nil }
        do {
            let html = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],  documentAttributes: nil)
            return html
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    func htmlAttributedStringWith(font: UIFont, color: UIColor) -> NSAttributedString {
        let html = "<font style=\"font-family:\(font.fontName); font-size:\(font.pointSize)px; color:#\(color.hexNoAlphaString)\">\(self)</font>"
        return html.data(using: .utf8).flatMap { data in
            try? NSAttributedString(
                data: data,
                options:
                    [
                        .documentType: NSAttributedString.DocumentType.html,
                        .characterEncoding: String.Encoding.utf8.rawValue
                    ],
                documentAttributes: nil
            )
        } ?? NSAttributedString()
    }
    
    var styledHtml: NSAttributedString? {
        return """
        <html>
        <head>
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\">
        <style>
        h1 { font-size: 19px; }
        h2 { font-size: 17px; }
        h3 { font-size: 15px; }
        </style>
        </head>
        <body style=\"font-family: '-apple-system', 'HelveticaNeue', Helvetica, sans-serif; font-size: 13; color: #3D3D3D;\">
        \(self)
        </body>
        </html>
        """.htmlAttributedString()
    }
}

extension String {
    
    var hexColor: UIColor {
        return UIColor(hex: self)
    }
    
    func targetSize(with font: UIFont, width: CGFloat? = nil) -> CGSize {
        
        return self.boundingRect(
            with: CGSize(width: width ?? CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil).size
    }
    
}

extension String {
    
    var nsString: NSString {
        NSString(string: self)
    }
}

extension String {
    
//    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = algorithm.digestLength
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        let keyStr = key.cString(using: String.Encoding.utf8)
//        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))
//        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
//        let digest = stringFromResult(result: result, length: digestLen)
//        result.deallocate()
//        return digest
//    }
//
//    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
//        let hash = NSMutableString()
//        for i in 0..<length {
//            hash.appendFormat("%02x", result[i])
//        }
//        return String(hash).lowercased()
//    }
}
