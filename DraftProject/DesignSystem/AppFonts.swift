//
//  AppFonts.swift
//
//  Created by LAV on 26.01.2023.
//

import UIKit

struct AppFonts {
    struct Title {
        static let H1 = UIFont.systemFont(ofSize: 24, weight: .semibold)
        static let H2 = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let H3 = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    struct Body {
        static let B1 = UIFont.systemFont(ofSize: 16, weight: .medium)
        static let B2 = UIFont.systemFont(ofSize: 16, weight: .regular)
        static let B3 = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    struct Caption {
        static let C1 = UIFont.systemFont(ofSize: 12, weight: .bold)
        static let C2 = UIFont.systemFont(ofSize: 12, weight: .semibold)
        static let C3 = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let C4 = UIFont.systemFont(ofSize: 10, weight: .medium)
    }
}
