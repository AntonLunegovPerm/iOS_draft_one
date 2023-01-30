//
//  Helpers.swift
//  DraftProject
//
//  Created by LAV on 27.01.2023.
//

import UIKit
import UserNotifications
import AVKit

func generateRandomString(_ length: Int, numericOnly: Bool) -> String {
    var alphabet: String
    if numericOnly {
        alphabet = "0123456789"
    } else {
        alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789"
    }

    var s = String()
    for _ in 0..<length {
        let r = Int(arc4random_uniform(UInt32(alphabet.count)))
        let char: Character = alphabet[alphabet.index(alphabet.startIndex, offsetBy: r)];
        s.append(char)
    }
    return s
}

func - (lhv: CGPoint, rhv: CGPoint) -> CGPoint {
    return CGPoint(x: lhv.x - rhv.x, y: lhv.y - rhv.y)
}

func getApplicationVersion() -> String {
    return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
}

func getDeviceID() -> String {
    let deviceIDKey = "DEVICE_ID_KEY"
    var deviceID = UserDefaults.standard.string(forKey: deviceIDKey)
    if deviceID == nil {
        deviceID = UIDevice.current.identifierForVendor?.uuidString
        if deviceID == nil {
            deviceID = UUID().uuidString
        }
        UserDefaults.standard.set(deviceID, forKey: deviceIDKey)
    }
    return deviceID!
}

func openAppSettings() {
    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
}


func getPreviewForVideo(at url: URL) -> UIImage? {
    let asset = AVAsset(url: url)
    let assetImageGenerator = AVAssetImageGenerator(asset: asset)
    assetImageGenerator.appliesPreferredTrackTransform = true

    var time = asset.duration
    time.value = min(time.value, Int64(Double(time.timescale) * 1.435))

    do {
        let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
        return UIImage(cgImage: imageRef)
    } catch {
        return nil
    }
}

func formattedFileSize(bytes: Int) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 0
    numberFormatter.maximumFractionDigits = 2
    let megabytes = Double(bytes) / (1024 * 1024)
    return (numberFormatter.string(from: megabytes as NSNumber) ?? "") + " MB"
}

func getCommonPriceFormatter() -> NumberFormatter {
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "ru_RU")
    numberFormatter.numberStyle = .currency
    numberFormatter.currencyCode = "RUB"
    numberFormatter.maximumFractionDigits = 0
    numberFormatter.roundingMode = .floor
    return numberFormatter
}

func call(phoneNumber: String) {
    if let url = URL(string: "tel:+\(phoneNumber.digitOnlyString())") {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
