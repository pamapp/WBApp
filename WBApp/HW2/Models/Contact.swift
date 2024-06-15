//
//  Contact.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

struct Contact: Identifiable, Hashable {
    let id = UUID()
    var name: String = ""
    var imageName: String?
    var lastSeen: Date = .init()
    var isStory: Bool = true
    var links: [SocialLink] = []
    var phoneNumber: String?
    
    var isOnline: Bool {
        Date().timeIntervalSince(lastSeen) < 60
    }

    var laseSeenText: String {
        let secondsAgo = Int(Date().timeIntervalSince(self.lastSeen))
        
        switch secondsAgo {
        case 0 ..< 60:
            return "Online"
        case 60 ..< 300:
            return "Last seen recently"
        case 300 ..< 3600:
            let minutesAgo = secondsAgo / 60
            return "Last seen \(minutesAgo) minutes ago"
        case 3600 ..< 86400:
            let hoursAgo = secondsAgo / 3600
            return "Last seen \(hoursAgo) hours ago"
        case 86400 ..< 172800:
            return "Last seen yersterday"
        default:
            return "Last seen \(self.lastSeen.dateToString(format: .short))"
        }
    }
}

struct SocialLink: Hashable {
    let media: SocialMedia
    let url: URL
    
    init(media: SocialMedia, url: String) {
        self.media = media
        self.url = URL(string: url)!
    }
}

enum SocialMedia {
    case twitter
    case instagram
    case linckedin
    case facebook
    
    var image: Image {
        switch self {
        case .facebook: Image(UI.Brands.facebook)
        case .instagram: Image(UI.Brands.instagram)
        case .linckedin: Image(UI.Brands.linckedin)
        case .twitter: Image(UI.Brands.twitter)
        }
    }
}

extension Contact {
    static let contacts: [Contact] = [
         .init(name: "Анастасия Иванова",
               imageName: "nastya",
               lastSeen: Date(timeIntervalSinceNow: -24 * 3600),
               isStory: false,
               links: [
                   SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                   SocialLink(media: .instagram, url: "https://instagram.com"),
               ],
               phoneNumber: "+7 999 999-99-99"),
         .init(name: "Петя",
               imageName: "petya",
               lastSeen: Date(),
               isStory: false,
               links: [
                   SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                   SocialLink(media: .instagram, url: "https://instagram.com"),
                   SocialLink(media: .linckedin, url: "https://linkedin.com"),
                   SocialLink(media: .twitter, url: "https://twitter.com"),
               ],
               phoneNumber: "+7 999 999-99-99"),
         .init(name: "Маман",
               imageName: "maman",
               lastSeen: Date(timeIntervalSinceNow: -3 * 3600),
               isStory: true,
               links: [
                   SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                   SocialLink(media: .instagram, url: "https://instagram.com"),
                   SocialLink(media: .linckedin, url: "https://linkedin.com"),
                   SocialLink(media: .twitter, url: "https://twitter.com"),
               ],
               phoneNumber: "+7 999 999-99-99"),
         .init(name: "Арбуз Дыня",
               imageName: "arbuz",
               lastSeen: Date(),
               isStory: false,
               links: [
                   SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                   SocialLink(media: .instagram, url: "https://instagram.com"),
                   SocialLink(media: .linckedin, url: "https://linkedin.com"),
                   SocialLink(media: .twitter, url: "https://twitter.com"),
               ],
               phoneNumber: "+7 999 999-99-99"),
         .init(name: "Иван Иванов",
               lastSeen: Date(),
               isStory: false,
               links: [
                   SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                   SocialLink(media: .instagram, url: "https://instagram.com"),
                   SocialLink(media: .linckedin, url: "https://linkedin.com"),
                   SocialLink(media: .twitter, url: "https://twitter.com"),
               ],
               phoneNumber: "+7 999 999-99-99"),
         .init(name: "Лиса Алиса",
               lastSeen: Date(timeIntervalSinceNow: -30 * 60),
               isStory: true,
               links: [
                   SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                   SocialLink(media: .instagram, url: "https://instagram.com"),
                   SocialLink(media: .linckedin, url: "https://linkedin.com"),
                   SocialLink(media: .twitter, url: "https://twitter.com"),
               ],
               phoneNumber: "+7 999 999-99-99"),
    ]
}
