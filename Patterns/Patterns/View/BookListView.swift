//
//  BookListView.swift
//  Patterns
//
//  Created by Alina Potapova on 23.07.2024.
//

import SwiftUI

struct BookListView: View {

    @EnvironmentObject var viewModel: BookListViewModel // Переданный (внедренный) viewModel через EnvironmentObject

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    bookSectionView(readed: false, title: Constants.unread)
                    bookSectionView(readed: true, title: Constants.read)
                }
                .navigationTitle(Constants.books)
                .toolbar {
                    NavigationLink(destination: BookAddView()) {
                        Image(systemName: Constants.addButton)
                            .symbolRenderingMode(.monochrome)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    private func bookSectionView(readed: Bool, title: String) -> some View {
        let books = viewModel.sortedBooks(readed: readed)
        
        return Section(header: Text(title)) {
            List {
                ForEach(books) { book in
                    bookCellView(for: book)
                }
                .onDelete { indexSet in
                    let booksToDelete = indexSet.map { books[$0] }
                    booksToDelete.forEach { viewModel.removeBook($0) }
                }
            }
        }
    }

    private func bookCellView(for book: Book) -> some View {
        HStack {
            bookInfoView(for: book)
            
            Spacer()
            
            isReadedToggleView(for: book)
        }
    }
    
    private func bookInfoView(for book: Book) -> some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(.headline)
            
            Text(book.author)
                .font(.subheadline)
        }
    }
    
    private func isReadedToggleView(for book: Book) -> some View {
        Button(action: { viewModel.setReaded(book: book) }) {
            Image(systemName: book.isRead ? Constants.readToggle : Constants.unreadToggle)
                .foregroundColor(book.isRead ? .green : .gray)
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

extension BookListView {
    private enum Constants {
        static let books = "Books"
        static let show = "Show"
        static let unread = "Unread"
        static let read = "Read"
        
        static let addButton = "plus.square.dashed"
        static let readToggle = "checkmark.circle.fill"
        static let unreadToggle = "circle"
    }
}
