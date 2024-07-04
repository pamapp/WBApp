//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by Alina Potapova on 04.07.2024.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI

extension ProfileEditor {
    private enum Constants {
        static let userInfo = "User Information"
        static let username = "Username"
        static let preferences = "Preferences"
        static let enableNotifications = "Enable Notifications"
        static let goalDate = "Goal Date"
        static let seasonalPhoto = "Seasonal Photo"
    }
}

struct ProfileEditor: View {
    @Binding var profile: Profile

    private var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }

    var body: some View {
        Form {
            userInfoSection
            preferencesSection
        }
    }
    
    private var userInfoSection: some View {
        Section(header: Text(Constants.userInfo)) {
            HStack {
                Text(Constants.username)
                Spacer()
                TextField(Constants.username, text: $profile.username)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.trailing)
            }
        }
    }

    private var preferencesSection: some View {
        Section(header: Text(Constants.preferences)) {
            Toggle(isOn: $profile.prefersNotifications) {
                Text(Constants.enableNotifications)
            }

            Picker(Constants.seasonalPhoto, selection: $profile.seasonalPhoto) {
                ForEach(Profile.Season.allCases, id: \.self) { season in
                    Text(season.rawValue).tag(season)
                }
            }
            .pickerStyle(.menu)

            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text(Constants.goalDate)
            }
        }
    }

}

#Preview {
    ProfileEditor(profile: .constant(.default))
}
