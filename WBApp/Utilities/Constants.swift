//
//  Constants.swift
//  WBApp
//
//  Created by Alina Potapova on 14.06.2024.

import SwiftUI

enum UI {
    struct Strings {
        static var search: String { localizedString(for: .search) }
        static var walkthroughText: String { localizedString(for: .walkthroughText) }
        static var userAgreement: String { localizedString(for: .userAgreement) }
        static var startChating: String { localizedString(for: .startChating) }
        static var dismiss: String { localizedString(for: .dismiss) }
        static var profile: String { localizedString(for: .profile) }
        static var contacts: String { localizedString(for: .contacts) }
        static var continueText: String { localizedString(for: .continueText) }
        static var enterPhoneNumber: String { localizedString(for: .enterPhoneNumber) }
        static var infoText: String { localizedString(for: .infoText) }
        static var enterCode: String { localizedString(for: .enterCode) }
        static var sendingCodeInfo: String { localizedString(for: .sendingCodeInfo) }
        static var requestCodeAgain: String { localizedString(for: .requestCodeAgain) }
        static var after: String { localizedString(for: .after) }
        static var invalidCode: String { localizedString(for: .invalidCode) }
        static var codeExpired: String { localizedString(for: .codeExpired) }
        
        static func localizedString(for key: LocalizationKeys) -> String {
            return key.rawValue.localized
        }
    }
    
    enum Icons {
        static let avatar: String = "avatar"
        static let edit: String = "edit"
        static let group: String = "group"
        static let message_circle: String = "message_circle"
        static let more_horizontal: String = "more_horizontal"
        static let search: String = "search"
        static let plus: String = "plus"
        static let back: String = "chevron.left"
    }
    
    enum Brands {
        static let facebook: String = "facebook"
        static let instagram: String = "instagram"
        static let linckedin: String = "linkedIn"
        static let twitter: String = "twitter"
    }
    
    enum Images {
        static let illustration: String = "Illustration"
    }
}
