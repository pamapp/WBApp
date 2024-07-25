//
//  BookListViewModel.swift
//  Patterns
//
//  Created by Alina Potapova on 23.07.2024.
//

import Foundation
import Combine

// MARK: - Observer pattern -

class BookListViewModel: ObservableObject {
    
    @Published var books: [Book] = []
            
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Подписка на Publisher, предоставляемый BookStore, для получения обновлений о списке книг
        BookStore.shared.$books
            .receive(on: DispatchQueue.main) // Обновления должны обрабатываться на главном потоке
            .sink { [weak self] books in // Подписчик (Subscriber) реагирует на новые данные
                self?.books = books // Обновление состояния `books` в ViewModel
            }
            .store(in: &cancellables) // Хранение подписки для управления её жизненным циклом
    }
    
    func addBook(title: String, author: String) {
        BookStore.shared.addBook(Book(title: title, author: author))
    }
    
    func removeBook(_ book: Book) {
        BookStore.shared.removeBook(book)
    }
    
    func setReaded(book: Book) {
        BookStore.shared.setReaded(book)
    }
    
    func sortedBooks(readed: Bool) -> [Book] {
        books.filter { $0.isRead == readed }
    }
}
