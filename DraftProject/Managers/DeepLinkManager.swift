//
//  DeepLinkManager.swift
//  DraftProject
//
//  Created by LAV on 09.10.2022.
//

import Foundation


enum DeepLinkNavigation: String {
    case profile
    case main
}

final class DeepLinkManager {

    static let shared = DeepLinkManager()

    private(set) var pendingNavigation: DeepLinkNavigation?

    func invalidatePendingNavigation() {
        pendingNavigation = nil
    }

    @discardableResult
    func handle(_ url: URL, save: Bool = false) -> DeepLinkNavigation? {
        guard let url = try? url.asURL() else {
            return nil
        }

        let navigation = handlers.lazy.compactMap { $0.handleDeepLink(url) }.first
        if save {
            pendingNavigation = navigation
        }

        return navigation
    }

    private let handlers: [DeepLinkHandler] = [
        ProfileDeepLinkHandler()
    ]
}

// MARK: DeepLinkHandler

protocol DeepLinkHandler {
    func canHandleDeepLink(_ url: URL) -> Bool
    func handleDeepLink(_ url: URL) -> DeepLinkNavigation?
}

private extension URL {

    func components(resolvingAgainstBaseURL: Bool = false) -> URLComponents? {
        return URLComponents(url: self, resolvingAgainstBaseURL: resolvingAgainstBaseURL)
    }
}

// MARK: MessagesDeepLinkHandler

struct ProfileDeepLinkHandler: DeepLinkHandler {

    func canHandleDeepLink(_ url: URL) -> Bool {
        if let deepLink = DeepLinkNavigation(rawValue: url.components()?.path.lowercased() ?? "") {
            return deepLink == .profile
        }
        return false
    }

    func handleDeepLink(_ url: URL) -> DeepLinkNavigation? {
        guard canHandleDeepLink(url) else {
            return nil
        }

        return .profile
    }
}
