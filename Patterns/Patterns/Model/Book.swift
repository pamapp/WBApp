//
//  Book.swift
//  Patterns
//
//  Created by Alina Potapova on 23.07.2024.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    var title: String
    var author: String
    var isRead: Bool = false
}
