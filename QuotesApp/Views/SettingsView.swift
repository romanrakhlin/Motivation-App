//
//  SettingsView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 02.11.2021.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    @Binding var backgroundImage: String
    @Binding var isSubscribed: Bool
    
    @ObservedObject var settingsViewModel = SettingsViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button(action: {
                    // some haptic thing
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    
                    self.dismiss()
                }) {
                    Text("Close")
                        .foregroundColor(Color.primary)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                }
                Spacer()
            }
            HStack {
                Text("Settings")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .padding(.horizontal, 20)
                Spacer()
            }
        }
        
        ScrollView {
                
            // MARK: - Main
            VStack(alignment: .leading) {
                Text("Main Features".uppercased())
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .kerning(1)
                
                // Notifications
                SettingsRow(imageName: "bell", title: "Notifications") {
                    self.settingsViewModel.showNotificationsView = true
                }
                .sheet(isPresented: $settingsViewModel.showNotificationsView) {
                    NotificationsView(isSubscribed: $isSubscribed)
                        .edgesIgnoringSafeArea(.bottom)
                }
                
                Divider()
                
                // App Icon
                SettingsRow(imageName: "app.fill", title: "App Icon") {
                    self.settingsViewModel.showChangeIconView = true
                }
                .sheet(isPresented: $settingsViewModel.showChangeIconView) {
                    ChangeIconView(isSubscribed: $isSubscribed)
                        .edgesIgnoringSafeArea(.bottom)
                }
            }
            .settingsBackground()
                
            // MARK: - Feedback
            VStack(alignment: .leading) {
                    
                // Rate the App
                SettingsRow(imageName: "star.square", title: "Write a review") {
                    self.settingsViewModel.writeReview()
                }
                
                Divider()
                    
                // Request New Feature
                SettingsRow(imageName: "wand.and.stars", title: "Feedback") {
                    if MFMailComposeViewController.canSendMail() {
                        self.settingsViewModel.showingFeatureEmail.toggle()
                    } else if let emailUrl = self.settingsViewModel.createEmailUrl(to: "admin@YOUR-URL.com", subject: "Feature request!", body: "Hello, I have this idea ") {
                        UIApplication.shared.open(emailUrl)
                    } else {
                        self.settingsViewModel.showMailFeatureAlert = true
                    }
                }
                .alert(isPresented: $settingsViewModel.showMailFeatureAlert) {
                    Alert(title: Text("No Mail Accounts"), message: Text("Please set up a Mail account in order to send email"), dismissButton: .default(Text("OK")))
                }
                .sheet(isPresented: $settingsViewModel.showingFeatureEmail) {
                    MailView(isShowing: self.$settingsViewModel.showingFeatureEmail, result: self.$settingsViewModel.featureResult, subject: "Feature request!", message: "Hello, I have this idea ")
                }
                
                Divider()
                    
                // Report A Bug
                SettingsRow(imageName: "tornado", title: "Report a bug") {
                    if MFMailComposeViewController.canSendMail() {
                        self.settingsViewModel.showingBugEmail.toggle()
                    } else if let emailUrl = self.settingsViewModel.createEmailUrl(to: "admin@YOUR-URL.com", subject: "BUG!", body: "Oh no, there's a bug ") {
                        UIApplication.shared.open(emailUrl)
                    } else {
                        self.settingsViewModel.showMailBugAlert = true
                    }
                }
                .alert(isPresented: self.$settingsViewModel.showMailBugAlert) {
                    Alert(title: Text("No Mail Accounts"), message: Text("Please set up a Mail account in order to send email"), dismissButton: .default(Text("OK")))
                }
                .sheet(isPresented: $settingsViewModel.showingBugEmail) {
                    MailView(isShowing: self.$settingsViewModel.showingBugEmail, result: self.$settingsViewModel.bugResult, subject: "BUG!", message: "Oh no, there's a bug ")
                }
            }
            .settingsBackground()

            // MARK: - About Company
            VStack(alignment: .leading) {
                Text("About Us".uppercased())
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .kerning(1)
                
                // More Apps
                SettingsRow(imageName: "apps.iphone", title: "More Apps") {
                    openURL(URL(string: "https://YOUR-URL.com")!)
                }
                
                Divider()

                // Link To Website
                SettingsRow(imageName: "arrow.up.forward", title: "About Us", action: {
                    openURL(URL(string: "https://YOUR-URL.com")!)
                })
            }
            .settingsBackground()
        }
    }
}
