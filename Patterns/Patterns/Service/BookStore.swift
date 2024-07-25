//
//  BookStore.swift
//  Patterns
//
//  Created by Alina Potapova on 25.07.2024.
//

import Foundation

// MARK: - Singleton pattern -

class BookStore: ObservableObject {
    
    static let shared = BookStore() // Единственный экземпляр BookStore, доступный глобально
    
    @Published private(set) var books: [Book] = [
        Book(title: "Преступление и наказание", author: "Фёдор Достоевский"),
        Book(title: "Анна Каренина", author: "Лев Толстой"),
        Book(title: "Мастер и Маргарита", author: "Михаил Булгаков"),
        Book(title: "Доктор Живаго", author: "Борис Пастернак"),
        Book(title: "Война и мир", author: "Лев Толстой"),
        Book(title: "Евгений Онегин", author: "Александр Пушкин"),
        Book(title: "Собачье сердце", author: "Михаил Булгаков")
    ]
    
    private init() {} // Приватный инициализатор для предотвращения создания других экземпляров
        
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func removeBook(_ book: Book) {
        books.removeAll { $0.id == book.id }
    }
    
    func setReaded(_ book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index].isRead.toggle()
        }
    }
}
