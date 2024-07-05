//
//  ProfileHost.swift
//  Landmarks
//
//  Created by Mac on 6/29/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

struct ProfileHost: View {
    @Environment (\.editMode) var editMode
    @Environment (\.dismiss) var dismiss
    @Environment(ModelData.self) var modelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button("Cancel", role: .cancel) {
                    switch editMode?.wrappedValue {
                    case .active:
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    default:
                        dismiss()
                    }
                }
                Spacer()
                EditButton()
            }
            .padding(.horizontal)
            .padding(.top)
            
            switch editMode?.wrappedValue {
            case .active:
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            default:
                ProfileSummary(profile: modelData.profile)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
