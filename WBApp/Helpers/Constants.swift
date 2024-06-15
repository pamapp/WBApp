//
//  Constants.swift
//  WBApp
//
//  Created by Alina Potapova on 14.06.2024.
//

import SwiftUI

enum UI {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    enum Strings {
        static let search: String = "Search"
        static let walkthrought_text: String = "Общайтесь с друзьями и близкими легко"
        static let userAgreement: String = "Пользовательское соглашение"
        static let startChating: String = "Начать общаться"
        static let dismiss: String = "Dismiss"
        static let profile: String = "Профиль"
        static let contacts: String = "Контакты"
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
