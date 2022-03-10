//
//  ContentView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import SwiftUI
import QuotesAppService
import PurchaseKit
import CryptoKit
import AppsFlyerLib

struct ContentView: View {
    
    // variables for customization
    @State private var backgroundImage = "black"
    @State private var currentChoice = String()
    
    // sheets
    @State private var showingCategoriesSheet = false
    @State private var showingFavoritesSheet = false
    @State private var showingSettingsSheet = false
    @State private var showingCustomizeSheet = false
    
    // for In-App Purchases
    @State private var showSubscriptionFlow: Bool = false
    @State var subscripbtionIsPurchased: Bool = false
    @State var anotherStatusChecker: String!
    
    // asynchronius of UI
    @State private var showActivityIndicator: Bool = true
    @State private var showContent: Bool = false
    
    // main
    let viewModel = ContentViewModel()
    @State private var allQuotes: [Quote] = []
    let notificationService = NotificationService()
    
    var body: some View {
        ZStack {
            if showContent {
                // MARK: - Quote Layer
                GeometryReader { proxy in
                    TabView {
                        ForEach(allQuotes, id: \.self) { quote in
                            QuoteView(quote: quote)
                        }
                        .rotationEffect(.degrees(-90))
                        .frame(
                            width: proxy.size.width,
                            height: proxy.size.height
                        )
                    }
                    .frame(
                        width: proxy.size.height,
                        height: proxy.size.width
                    )
                    .rotationEffect(.degrees(90), anchor: .topLeading)
                    .offset(x: proxy.size.width)
                    .tabViewStyle(
                        PageTabViewStyle(indexDisplayMode: .never)
                    )
                }
                    
                // MARK: - UX Buttons and Stuff
                VStack {
                        
                    // MARK: - Top level
                    HStack {
                        Button(action: {
                            // the analytics of click
                            logEventAnalytics("change background button tapped", 1)
                            
                            showingCustomizeSheet.toggle()
                            
                            // some haptic thing
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }) {
                            Image(systemName: "paintbrush.pointed")
                                .renderingMode(.original)
                                .foregroundColor(.white)
                                .frame(width: 25, height: 25)
                                .padding()
                        }
                        .sheet(isPresented: $showingCustomizeSheet) {
                            BackgroundImageView(backgroundImagee: $backgroundImage, isSubscribed: $subscripbtionIsPurchased)
                                .edgesIgnoringSafeArea(.bottom)
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(14)
                        .buttonStyle(PlainButtonStyle())
                                            
                        Spacer()
                                            
                        Button(action: {
                            // the analytics of click
                            logEventAnalytics("settings button tapped", 1)
                            
                            self.showingSettingsSheet.toggle()
                                                                    
                            // some haptic thing
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }) {
                            Image(systemName: "gearshape")
                                .renderingMode(.original)
                                .foregroundColor(.white)
                                .frame(width: 25, height: 25)
                                .padding()
                        }.sheet(isPresented: $showingSettingsSheet) {
                            SettingsView(backgroundImage: $backgroundImage, isSubscribed: $subscripbtionIsPurchased)
                                .edgesIgnoringSafeArea(.bottom)
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(14)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical, 50)
                    .padding(.horizontal, 20)
                        
                    Spacer()
                        
                    // MARK: - Bottom level
                    HStack {
                        Button(action: {
                            // the analytics of click
                            logEventAnalytics("change category button tapped", 1)
                            
                            self.showingCategoriesSheet.toggle()

                            // some haptic thing
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }) {
                            HStack {
                                Image("categories")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 25, height: 25)
                                Text("\(currentChoice)")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .padding()
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(14)
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showingCategoriesSheet) {
                            CategoriesView(currentChoice: $currentChoice, updatedQuotes: $allQuotes, isSubscribed: $subscripbtionIsPurchased)
                        }

                        Spacer()

                        Button(action: {
                            // the analytics of click
                            logEventAnalytics("favorites button tapped", 1)
                            
                            if subscripbtionIsPurchased {
                                self.showingFavoritesSheet.toggle()
                            } else {
                                self.showSubscriptionFlow.toggle()
                            }

                            // some haptic thing
                            let impactMed = UIImpactFeedbackGenerator(style: .medium)
                            impactMed.impactOccurred()
                        }) {
                            Image(systemName: "archivebox")
                                .renderingMode(.original)
                                .foregroundColor(.white)
                                .frame(width: 25, height: 25)
                                .padding()
                        }
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(14)
                        .buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showingFavoritesSheet) {
                            FavoritesView()
                                .edgesIgnoringSafeArea(.bottom)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 40)
                }
                .font(.system(size: 18, weight: .bold, design: .rounded))
            }
        }
        .onAppear {
            onAppear()
        }
        .background(
            Image(backgroundImage)
                .resizable()
                .scaledToFill()
                .blur(radius: 1)
        )
        .ignoresSafeArea()
        .task(showIndicator)
        .fullScreenCover(isPresented: $showSubscriptionFlow, content: { SubscriptionFlow })
        
        if showActivityIndicator {
            ActivityIndicator()
                .frame(width: 75, height: 75)
                .foregroundColor(Color.gray)
        }
    }
    
    private var SubscriptionFlow: some View {
        SubscribeView(
            title: "Motivation App",
            subtitle: "Daily Quotes",
            features: ["Enjoy your first 3 days trial, it’s free", "Cancel anytime from the settings", "Push notifications with quotes", "Categories for any situation", "Original themes"],
            productIds: ["YOUR-PRODUCT'S-ID"],
            completion: { error, status, _ in
                if status == .success {
                    subscripbtionIsPurchased = true
                } else if status == .restored {
                    subscripbtionIsPurchased = true
                }
                guard let errorMessage = error else { return }
                print(errorMessage)
            },
            isOnboarding: false
        )
    }
        
    @Sendable private func showIndicator() async {
        // we could just use the specific amount of milliseconds
        // BUTTTTT shit happens and smthg could possibly go wrong
        // so anotherStatusChecker bt default is nil
        // and we waiting while it becomes something
        // is something wring with internet etc will be infinite loading
        // so its perfect solution!!!!
        
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
//        try? await Task.sleep(nanoseconds: 0_500_000_000)
        print("Checking subscription...")
        while anotherStatusChecker == nil {
            
        }
        showActivityIndicator = false
        showContent = true
    }

    private func onAppear() {
        PKManager.verifySubscription(identifier: "YOUR-PRODUCT'S-ID") { (error, status, _) in
            if status == .success {
                print("SUBSCRIBED")
                self.subscripbtionIsPurchased = true
                self.anotherStatusChecker = "done"
            } else {
                print("NOT SUBSCRIBED")
                self.anotherStatusChecker = "done"
            }
        }
        
        backgroundImage = UserDefaults.standard.string(forKey: "SavedBackground") ?? "back-0"
        currentChoice = UserDefaults.standard.string(forKey: "currentChoice") ?? "inspirational"
        
        allQuotes = viewModel.getAllQuotes(by: currentChoice)
        
        // reschedule notifications
        notificationService.removePendingNotificationRequests()
        notificationService.clearDeliveredNotificationRequests()
        
        let firstDate = UserDefaults.standard.date(forKey: "firstDate")
        let secondDate = UserDefaults.standard.date(forKey: "secondDate")
        let howMany = UserDefaults.standard.integer(forKey: "howMany")
            
        if (firstDate != nil && secondDate != nil && howMany != 0) {
            notificationService.scheduleAllNotifications(from: firstDate!, to: secondDate!, count: howMany)
        }
    }
    
    private func logEventAnalytics(_ text: String, _ number: Int) {
        AppsFlyerLib.shared().logEvent(
            text,
            withValues:[
                AFEventParamContentId: "\(number)",
                AFEventParamContentType : "main_screen_buttons"
            ]
        )
    }
}

// MARK: - The Activity Indicator for Content View
struct ActivityIndicator: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0..<5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(calcScale(index: index))
                        .offset(y: calcYOffset(geometry))
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                                .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
    
    private func calcScale(index: Int) -> CGFloat {
        return (!isAnimating ? 1 - CGFloat(Float(index)) / 5 : 0.2 + CGFloat(index) / 5)
    }
    
    private func calcYOffset(_ geometry: GeometryProxy) -> CGFloat {
        return geometry.size.width / 10 - geometry.size.height / 2
    }
}
