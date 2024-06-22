//
//  Contact.swift
//  WBApp
//
//  Created by Alina Potapova on 13.06.2024.
//

import SwiftUI

struct Contact: Identifiable, Hashable  {
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
