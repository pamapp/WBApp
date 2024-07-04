//
//  SharedData.swift
//  WBApp
//
//  Created by Alina Potapova on 17.06.2024.
//

import Foundation

class SharedData {
    static let shared = SharedData()
    
    var currentContactIndex: Int = 0
    
    var contacts: [Contact] = [
        .init(name: "Анастасия Иванова",
              imageName: "nastya",
              lastSeen: .init(timeIntervalSinceNow: -24 * 3600),
              isStory: false,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2016-04-18T12:42:20+0000"),
        .init(name: "Петя",
              imageName: "petya",
              lastSeen: .init(),
              isStory: false,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2016-11-14T10:44:00+0000"),
        .init(name: "Маман",
              imageName: "maman",
              lastSeen: .init(timeIntervalSinceNow: -3 * 3600),
              isStory: true,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2018-04-14T13:01:06+0000"),
        .init(name: "Арбуз Дыня",
              imageName: "arbuz",
              lastSeen: .init(),
              isStory: false,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2021-01-1T07:24:37+0000"),
        .init(name: "Иван Иванов",
              lastSeen: .init(),
              isStory: false,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2015-10-09T11:25:00+0000"),
        .init(name: "Лиса Алиса",
              lastSeen: .init(timeIntervalSinceNow: -30 * 60),
              isStory: true,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2016-06-14T09:44:00+0000"),
        .init(name: "Вова",
              imageName: "vova",
              lastSeen: .init(),
              isStory: false,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2017-09-09T10:44:00+0000"),
        .init(name: "Валерий",
              imageName: "valera",
              lastSeen: .init(timeIntervalSinceNow: -30 * 216000),
              isStory: false,
              links: [
                  SocialLink(media: .facebook, url: "https://www.facebook.com/zuck"),
                  SocialLink(media: .instagram, url: "https://instagram.com"),
                  SocialLink(media: .linckedin, url: "https://linkedin.com"),
                  SocialLink(media: .twitter, url: "https://twitter.com"),
              ],
              phoneNumber: "+7 999 999-99-99",
              creationDate: "2023-12-19T10:54:01+0000"),
    ]
    
    private init() {}
}
