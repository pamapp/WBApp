//
//  BookAddView.swift
//  Patterns
//
//  Created by Alina Potapova on 23.07.2024.
//

import SwiftUI

struct BookAddView: View {
    
    @EnvironmentObject var viewModel: BookListViewModel // Переданный (внедренный) viewModel через EnvironmentObject

    @State private var title = ""
    @State private var author = ""
    @State private var isReaded = false

    var body: some View {
        Form {
            Section(header: Text(Constants.bookDetails)) {
                TextField(Constants.title, text: $title)
                TextField(Constants.author, text: $author)
            }
            
            Button(action: {
                guard title != "" && author != "" else { return }
                viewModel.addBook(title: title, author: author)
                title = ""
                author = ""
            }) {
                Text(Constants.addBook)
            }
        }
        .navigationTitle(Constants.newBook)
    }
}

extension BookAddView {
    private enum Constants {
        static let bookDetails = "Book Details"
        static let title = "Title"
        static let author = "Author"
        static let newBook = "New Book"
        static let addBook = "Add Book"
    }
}
