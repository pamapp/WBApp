//
//  ContactsView.swift
//  WBApp
//
//  Created by Alina Potapova on 08.06.2024.
//

import SwiftUI

struct ContactsListView: View {
    @EnvironmentObject var router: Router
   
    @State private var searchText = ""
    
    let onContactTap: (Contact) -> Void
    
    var body: some View {
        NavigationStack {
            GeometryReader  { geo in
                VStack(spacing: 0) {
                    SearchBarView(text: $searchText)
                        .padding(.horizontal, 24)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    
                    List(Contact.contacts.filter {
                        searchText.isEmpty ? true : $0.name.contains(searchText)
                    }) { contact in
                        ContactRowView(contact: contact)
                            .padding(5)
                            .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                                return 4
                            }
                            .alignmentGuide(.listRowSeparatorTrailing) { viewDimensions in
                                return viewDimensions.width - 4
                            }
                            .onTapGesture {
                                onContactTap(contact)
                            }
                            .listRowBackground(Color.theme.white)
                    }
                    .listStyle(.plain)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                }
                .background(Color.theme.white)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: NavigationBarTitle(title: UI.Strings.contacts).padding(.leading, 8),
                trailing: NavigationBarButton(imageName: UI.Icons.plus, action: {})
            )
        }
    }
}

#Preview {
    ContentView()
}
