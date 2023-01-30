//
//  UpdateManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation
import UIKit

enum VersionError: Error {
    case invalidBundleInfo, invalidResponse
}

class LookupResult: Decodable {
    var results: [AppInfo]
}

class AppInfo: Decodable {
    var version: String
    var trackViewUrl: String
}

class UpdateManager: NSObject {

//    private override init() {}
//    static let shared = UpdateManager()

    func checkVersion(onNeedUpdate: ((Bool)->())?) {
        DispatchQueue.global().async {
            let info = Bundle.main.infoDictionary
            if let currentVersion = info?["CFBundleShortVersionString"] as? String {
                _ = self.getAppInfo { (info, error) in
                    let version = info?.version.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                    if let appStoreAppVersion = version {
                        if let error = error {
                            print("error getting app store version: ", error)
                            onNeedUpdate?(false)
                        } else if appStoreAppVersion == currentVersion {
                            print("Already on the last app version: ",currentVersion)
                            onNeedUpdate?(false)
                        } else if appStoreAppVersion > currentVersion {
                            print("Needs update: AppStore Version: \(appStoreAppVersion) > Current version: ",currentVersion)
                            DispatchQueue.main.async {
                                onNeedUpdate?(true)
                            }
                        } else {
                            onNeedUpdate?(false)
                        }
                    } else {
                        onNeedUpdate?(false)
                    }
                }
            } else {
                onNeedUpdate?(false)
            }
        }
    }

    private func getAppInfo(completion: @escaping (AppInfo?, Error?) -> Void) -> URLSessionDataTask? {
        guard let identifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String,
            let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                DispatchQueue.main.async {
                    completion(nil, VersionError.invalidBundleInfo)
                }
                return nil
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let result = try JSONDecoder().decode(LookupResult.self, from: data)
                guard let info = result.results.first else { throw VersionError.invalidResponse }

                completion(info, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
}

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
