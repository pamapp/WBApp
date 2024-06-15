//
//  ContactsView.swift
//  WBApp
//
//  Created by Alina Potapova on 08.06.2024.
//

import SwiftUI

extension ContactsListView {
    private enum Constants {
        static let spacing: CGFloat = 4
        static let searchBarTopPadding: CGFloat = 16
        static let searchBarHorizontalPadding: CGFloat = 24
        static let rowPadding: CGFloat = 5
        static let rowSeparatorPadding: CGFloat = 4
    }
}

struct ContactsListView: View {
    @EnvironmentObject var router: Router
    @State private var searchText = ""
    
    let onContactTap: (Contact) -> Void
    
    var body: some View {
        NavigationStack {
            GeometryReader  { geo in
                VStack(spacing: Constants.spacing) {
                    SearchBarView(text: $searchText)
                        .padding(.horizontal, Constants.searchBarHorizontalPadding)
                        .padding(.top, Constants.searchBarTopPadding)
                    
                    listView
                }
                .background(Color.theme.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: NavigationBarItemView(title: UI.Strings.contacts),
                trailing: NavigationBarItemView(imageName: UI.Icons.plus, action: {})
            )
        }
    }
}

extension ContactsListView {
    private var listView: some View {
        List(Contact.contacts.filter {
            searchText.isEmpty ? true : $0.name.contains(searchText)
        }) { contact in
            ContactRowView(contact: contact)
                .listRowBackground(Color.theme.white)
                .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                    return Constants.rowSeparatorPadding
                }
                .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
                    return viewDimensions.width - Constants.rowSeparatorPadding
                }
                .onTapGesture {
                    onContactTap(contact)
                }
                .padding(Constants.rowPadding)
        }
        .listStyle(.plain)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

#Preview {
    ContentView()
}
