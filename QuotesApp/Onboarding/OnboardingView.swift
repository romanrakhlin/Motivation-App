//
//  OnboardingViewPure.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 05.11.2021.
//

import SwiftUI

struct OnboardingView: View {
    
    var data: [OnboardingDataModel]
    var doneFunction: () -> ()
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    @State private var showSubscriptionFlow: Bool = false
    
    @State private var typeOf = "Motivation" // for type of
    
    // parametrs (as indeces in array)
    @State var howMany: Int = 1
    @State var from: Int = 0
    @State var to: Int = 47
    
    let arrayOfTimes = ["12:00 AM", "12:30 AM", "1:00 AM", "1:30 AM", "2:00 AM", "2:30 AM", "3:00 AM", "3:30 AM", "4:00 AM", "4:30 AM", "5:00 AM", "5:30 AM", "6:00 AM", "6:30 AM", "7:00 AM", "7:30 AM", "8:00 AM", "8:30 AM", "9:00 AM", "9:30 AM", "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "1:00 PM", "1:30 PM", "2:00 PM", "2:30 PM", "3:00 PM", "3:30 PM", "4:00 PM", "4:30 PM", "5:00 PM", "5:30 PM", "6:00 PM", "6:30 PM", "7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM", "9:00 PM", "9:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM"]
    
    @State var showingFailAlert = false
     
    let notificationService = NotificationService()
    
    var body: some View {
        ZStack {
            ZStack(alignment: .center) {
                ForEach(0..<4) { i in
                    EachOnboardingView(data: self.data[i], count: i, typeOf: $typeOf, howMany: $howMany, from: $from, to: $to, arrayOfTimes: arrayOfTimes)
                        .offset(x: CGFloat(i) * self.distance)
                        .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                        .animation(.spring())
                }
            }
            
            VStack {
                VStack {
                    Spacer()
                    HStack {
                        HStack {
                            ForEach(0..<data.count) { i in
                                Circle()
                                    .scaledToFit()
                                    .frame(width: 10)
                                    .foregroundColor(self.curSlideIndex >= i ? Color.black : Color(.systemGray))
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: nextButton) {
                            Image("go")
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .black)
                                .padding(10)
                        }
                    }
                }
                .padding(20)
            }
        }
        .background(Color.white)
        .fullScreenCover(isPresented: $showSubscriptionFlow, content: {
            SubscribeView(
                title: "Motivation App",
                subtitle: "Daily Quotes",
                features: ["Enjoy your first 3 days trial, it’s free", "Cancel anytime from the settings", "Push notifications with quotes", "Categories for any situation", "Original themes"],
                productIds: ["YOUR-PRODUCT'S-ID"],
                isOnboarding: true
            )
        })
        .alert("The start time can't be equal to the end time", isPresented: $showingFailAlert) { }
    }
    
    private func nextButton() {
        // some haptic thing
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
        
        if self.curSlideIndex == 0 {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
        } else if self.curSlideIndex == 1 {
            scheduleNotifications()
        } else if self.curSlideIndex == self.data.count - 1 {
            // when the sceen is the last one
            doneFunction()
            showSubscriptionFlow = true
            return
        }
              
        withAnimation {
            self.curSlideIndex += 1
        }
    }
    
    private func scheduleNotifications() {
        if from == to {
            showingFailAlert.toggle()
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
            UserDefaults.standard.set(true, forKey: "wasAlreadyScheduled")
        }
    }
    
    private func saveParams() {
        UserDefaults.standard.set(typeOf, forKey: "typeOf")
        UserDefaults.standard.set(from, forKey: "from")
        UserDefaults.standard.set(to, forKey: "to")
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
