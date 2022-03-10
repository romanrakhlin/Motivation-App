//
//  NotificationsView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 05.11.2021.
//

import SwiftUI
import UserNotifications
import QuotesAppService

struct NotificationsView: View {
    @Environment(\.dismiss) var dismiss
    let notificationService = NotificationService()
    @State private var allowNotifications = false
    @State private var wasAlreadyScheduled = false

    // params
    @State var typeOf: String = "Motivation"
    @State var howMany: Int = 1
    @State var from: Int = 0
    @State var to: Int = 1
    
    let arrayOfTimes = ["12:00 AM", "12:30 AM", "1:00 AM", "1:30 AM", "2:00 AM", "2:30 AM", "3:00 AM", "3:30 AM", "4:00 AM", "4:30 AM", "5:00 AM", "5:30 AM", "6:00 AM", "6:30 AM", "7:00 AM", "7:30 AM", "8:00 AM", "8:30 AM", "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM", "5:30 PM", "6:00 PM", "6:30 PM", "7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM", "9:00 PM", "9:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM"]
    
    // work with subscribtion
    @State private var showSubscriptionFlow: Bool = false
    @Binding var isSubscribed: Bool
    
    // alerts
    @State var showingFailAlert: Bool = false
    @State var showingCategoriesAlert: Bool = false
    @State var showingDoneAlert: Bool = false
    @State var showingEraseAlert: Bool = false
    @State var showWasAlreadyScheduledAlert: Bool = false
    @State var showingNotificationsAlert: Bool = false
    
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
                    
                    if !isSubscribed {
                        Button(action: {
                            showSubscriptionFlow.toggle()
                            
                            // some haptic thing
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }) {
                            Text("Unlock")
                                .foregroundColor(Color.primary)
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                        }
                    }
                }
                
                HStack {
                    Text("Notifications")
                        .font(.system(size: 28, weight: .heavy, design: .rounded))
                        .padding(.horizontal, 20)
                    Spacer()
                }
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Type of")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        Menu {
                            Picker("picker", selection: $typeOf, content: {
                                Text("Motivation").background(Color.white).tag("Motivation")
                                Text("Time").tag("Time")
                                Text("Wisdom").tag("Wisdom")
                                Text("Inspiration").tag("Inspiration")
                                Text("Love").tag("Love")
                                Text("Success").tag("Success")
                                Text("Happiness").tag("Happiness")
                                Text("Life Lessons").tag("Life Lessons")
                                Text("Spirituality").tag("Spirituality")
                                Text("Philosophy").tag("Philosophy")
                            })
                            .labelsHidden()
                            .pickerStyle(InlinePickerStyle())

                        } label: {
                            Text(typeOf)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("How many:")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                if howMany != 1 {
                                    howMany -= 1
                                }
                            }) {
                                Image(systemName: "minus.square")
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                            
                            Text("\(howMany)X")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                            
                            Button(action: {
                                if howMany != 15 {
                                    howMany += 1
                                }
                            }) {
                                Image(systemName: "plus.square")
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Starts:")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                if from != 0 {
                                    from -= 1
                                }
                            }) {
                                Image(systemName: "minus.square")
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                            
                            Text(arrayOfTimes[from])
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                            
                            Button(action: {
                                if from != arrayOfTimes.count - 1 {
                                    from += 1
                                }
                            }) {
                                Image(systemName: "plus.square")
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Ends:")
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                if to != 1 {
                                    to -= 1
                                }
                            }) {
                                Image(systemName: "minus.square")
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                            
                            Text(arrayOfTimes[to])
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                            
                            Button(action: {
                                if to != arrayOfTimes.count - 1 {
                                    to += 1
                                }
                            }) {
                                Image(systemName: "plus.square")
                                    .padding()
                                    .foregroundColor(.primary)
                            }
                        }
                    }

                    Spacer()
                    
                    VStack {
                        Button(action: {
                            let current = UNUserNotificationCenter.current()
                            current.getNotificationSettings(completionHandler: { permission in
                                switch permission.authorizationStatus  {
                                case .authorized:
                                    showWasAlreadyScheduledAlert.toggle()
                                case .denied:
                                    showingNotificationsAlert.toggle()
                                @unknown default:
                                    print("Unknow Status")
                                }
                            })
                        }) {
                            Spacer()
                            Text("Schedule")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                            Spacer()
                        }
                        .padding()
                        .background(.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(13)
                        .alert("Subscribe To Pick Different Categories", isPresented: $showingCategoriesAlert) { }
                        .alert("The Start time can't be Equal to the End time", isPresented: $showingFailAlert) { }
                        .alert("Notifications Are Scheduled!", isPresented: $showingDoneAlert) { }
                        .alert("Do You Want To Reset Notifications?", isPresented: $showWasAlreadyScheduledAlert) {
                            // if user wanna reset already scheduled notifications
                            Button("Reset", role: .cancel) {
                                // erase previous
                                eraseAllNotifications()
                                
                                // create new ones
                                scheduleNotifications()
                            }
                        }
                        
                        Button(action: {
                            eraseAllNotifications()
                            
                            showingEraseAlert.toggle()
                            
                            // some haptic thing
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }) {
                            Spacer()
                            Text("Disable")
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                            Spacer()
                        }
                        .padding()
                        .background(.black.opacity(0.4))
                        .foregroundColor(.white)
                        .cornerRadius(13)
                        .alert("All Notifications Are Erased", isPresented: $showingEraseAlert) { }
                    }
                }
                .padding(.horizontal, 20)
            }.onAppear {
                allowNotifications = UserDefaults.standard.bool(forKey: "AllowNotifications")
                
                // Ask to Allow Notifications If Disabled
                if !allowNotifications {
                    UNUserNotificationCenter.current()
                        .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("All set!")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                }
                
                // laod params
                wasAlreadyScheduled = UserDefaults.standard.bool(forKey: "wasAlreadyScheduled") ?? false
                howMany = UserDefaults.standard.integer(forKey: "howMany") ?? 1
                from = UserDefaults.standard.integer(forKey: "from") ?? 0
                to = UserDefaults.standard.integer(forKey: "to") ?? 1
            }
            .alert("You Need to Allow Notifications", isPresented: $showingNotificationsAlert) {
                Button("Allow", role: .cancel) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                }
            }
            .fullScreenCover(isPresented: $showSubscriptionFlow, content: { SubscriptionFlow })
            .font(.system(size: 18, weight: .bold, design: .rounded))
        }
    
    private var SubscriptionFlow: some View {
        SubscribeView(
            title: "Motivation App",
            subtitle: "Daily Quotes",
            features: ["Enjoy your first 3 days trial, it’s free", "Cancel anytime from the settings", "Push notifications with quotes", "Categories for any situation", "Original themes"],
            productIds: ["YOUR-PRODUCT'S-ID"],
            completion: { error, status, _ in
                /// Handle the error and status for each in-app purchase based on the productIdentifier
                if status == .success || status == .restored {
                    /// If the purchase was successful or restored, unlock any content, remove ads or do anything you have to do
                    isSubscribed = true
                    dismiss()
                }
                guard let errorMessage = error else { return }
                print(errorMessage)
            },
            isOnboarding: false
        ).edgesIgnoringSafeArea(.bottom)
    }
    
    private func scheduleNotifications() {
        // ask to allow notification
        if from == to {
            showingFailAlert.toggle()
        } else {
            if typeOf != "Motivation" && !isSubscribed {
                showingCategoriesAlert.toggle()
            } else {
                let firstDate = to24Hours(string: arrayOfTimes[from])
                let secondDate = to24Hours(string: arrayOfTimes[to])
                notificationService.scheduleAllNotifications(from: firstDate, to: secondDate, count: howMany)
                
                // save parametrs to User Defaults
                UserDefaults.standard.set(date: firstDate, forKey: "firstDate")
                UserDefaults.standard.set(date: secondDate, forKey: "secondDate")
                UserDefaults.standard.set(howMany, forKey: "howMany")
                
                // some haptic thing
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                
                // save params to user defaults
                saveParams()
                
                // save wasAlreadyScheduled
                wasAlreadyScheduled = true
                UserDefaults.standard.set(wasAlreadyScheduled, forKey: "wasAlreadyScheduled")
                
                showingDoneAlert.toggle()
            }
        }
    }
    
    private func saveParams() {
        UserDefaults.standard.set(typeOf, forKey: "typeOf")
        UserDefaults.standard.set(from, forKey: "from")
        UserDefaults.standard.set(to, forKey: "to")
    }
    
    private func eraseAllNotifications() {
        notificationService.removePendingNotificationRequests()
        notificationService.clearDeliveredNotificationRequests()
    }
    
    private func to24Hours(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // fixes nil if device time in 24 hour format
        let date = dateFormatter.date(from: string)
        print(date!)
        return date!
    }
}
