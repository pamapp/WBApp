//
//  CountryCodesProvider.swift
//  WBApp
//
//  Created by Alina Potapova on 05.07.2024.
//

import Foundation

struct CountryCodesProvider {
    static let codes: [String: (phoneCode: String, phoneFormat: String, digitsCount: Int)] = [
        "RU": ("+7", "(000) 000-00-00", 10),
        "AM": ("+374", "(000) 00-00-00", 9),
        "AZ": ("+994", "(000) 000-00-00", 10),
        "BY": ("+375", "(000) 000-00-00", 10),
        "CN": ("+86", "(000) 0000-0000", 11),
        "GB": ("+44", "(0000) 000000", 10),
        "KG": ("+996", "(000) 000-000", 9),
        "KZ": ("+7", "(000) 000-00-00", 10),
        "US": ("+1", "(000) 000-0000", 10),
        "UZ": ("+998", "(000) 000-00-00", 10),
        "TR": ("+90", "(000) 000-00-00", 10),
        "GE": ("+995", "(000) 00-00-00", 9),
        "KR": ("+82", "(000) 000-0000", 10),
        "AE": ("+971", "(000) 000-0000", 10)
    ]
    
    static func flag(for id: String) -> String {
        return id
    }
    
    static func phoneCode(for id: String) -> String {
        return codes[id]?.phoneCode ?? ""
    }
    
    static func phoneFormat(for id: String) -> String {
        return codes[id]?.phoneFormat ?? ""
    }
    
    static func digitsCount(for id: String) -> Int {
        return codes[id]?.digitsCount ?? 0
    }
}
