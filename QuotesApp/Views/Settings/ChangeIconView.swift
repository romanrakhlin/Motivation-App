//
//  ChangeIconView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 05.11.2021.
//

import SwiftUI

struct ChangeIconView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // rows
    let firstRow: [[String]] = [
        ["AppIcon-1","icon-1"], ["AppIcon-2","icon-2"], ["AppIcon-3","icon-3"], ["AppIcon-4","icon-4"],
        ["AppIcon-5","icon-5"], ["AppIcon-6","icon-6"], ["AppIcon-7","icon-7"]
    ]
    let secondRow: [[String]] = [
        ["AppIcon-8","icon-8"], ["AppIcon-9","icon-9"], ["AppIcon-10","icon-10"], ["AppIcon-11","icon-11"],
        ["AppIcon-12","icon-12"], ["AppIcon-13","icon-13"], ["AppIcon-14","icon-14"], ["AppIcon-15","icon-15"]
    ]
    let thirdRow: [[String]] = [
        ["AppIcon-16","icon-16"], ["AppIcon-17","icon-17"], ["AppIcon-18","icon-18"], ["AppIcon-19","icon-19"],
        ["AppIcon-20","icon-20"], ["AppIcon-21","icon-21"], ["AppIcon-22","icon-22"], ["AppIcon-23","icon-23"]
    ]
    let fouthRow: [[String]] = [
        ["AppIcon-24","icon-24"], ["AppIcon-25","icon-25"], ["AppIcon-26","icon-26"], ["AppIcon-27","icon-27"],
        ["AppIcon-28","icon-28"], ["AppIcon-29","icon-29"], ["AppIcon-30","icon-30"], ["AppIcon-31","icon-31"]
    ]
    
    // work with subscribtion
    @State private var showSubscriptionFlow: Bool = false
    @Binding var isSubscribed: Bool
    
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
                        Text("Unlock All")
                            .foregroundColor(Color.primary)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                    }
                }
            }
            
            HStack {
                Text("App Icon")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .padding(.horizontal, 20)
                Spacer()
            }
        }
        
        ScrollView(showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) {
                VStack(alignment: .center, spacing: 20) {
                    HStack {
                        Button(action: {
                            UIApplication.shared.setAlternateIconName(nil)
                        }) {
                            Image("icon")
                                .resizable()
                                .scaledToFit()
                        }
                        .cornerRadius(10)
                    }
                    
                    ForEach(firstRow, id: \.self) { icon in
                        HStack {
                            Button(action: {
                                if isSubscribed {
                                    UIApplication.shared.setAlternateIconName(icon[0]) { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        } else {
                                            print("Success!")
                                        }
                                    }
                                } else {
                                    showSubscriptionFlow.toggle()
                                }
                            }) {
                                if isSubscribed {
                                    Image(icon[1])
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    ZStack {
                                        Image(icon[1])
                                            .resizable()
                                            .scaledToFit()
                                        Image("lock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35, alignment: .center)
                                    }
                                }
                            }.cornerRadius(10)
                        }
                    }
                }
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach(secondRow, id: \.self) { icon in
                        HStack {
                            Button(action: {
                                if isSubscribed {
                                    UIApplication.shared.setAlternateIconName(icon[0]) { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        } else {
                                            print("Success!")
                                        }
                                    }
                                } else {
                                    showSubscriptionFlow.toggle()
                                }
                            }) {
                                if isSubscribed {
                                    Image(icon[1])
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    ZStack {
                                        Image(icon[1])
                                            .resizable()
                                            .scaledToFit()
                                        Image("lock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35, alignment: .center)
                                    }
                                }
                            }.cornerRadius(10)
                        }
                    }
                }
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach(thirdRow, id: \.self) { icon in
                        HStack {
                            Button(action: {
                                if isSubscribed {
                                    UIApplication.shared.setAlternateIconName(icon[0]) { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        } else {
                                            print("Success!")
                                        }
                                    }
                                } else {
                                    showSubscriptionFlow.toggle()
                                }
                            }) {
                                if isSubscribed {
                                    Image(icon[1])
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    ZStack {
                                        Image(icon[1])
                                            .resizable()
                                            .scaledToFit()
                                        Image("lock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35, alignment: .center)
                                    }
                                }
                            }.cornerRadius(10)
                        }
                    }
                }
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach(fouthRow, id: \.self) { icon in
                        HStack {
                            Button(action: {
                                if isSubscribed {
                                    UIApplication.shared.setAlternateIconName(icon[0]) { error in
                                        if let error = error {
                                            print(error.localizedDescription)
                                        } else {
                                            print("Success!")
                                        }
                                    }
                                } else {
                                    showSubscriptionFlow.toggle()
                                }
                            }) {
                                if isSubscribed {
                                    Image(icon[1])
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    ZStack {
                                        Image(icon[1])
                                            .resizable()
                                            .scaledToFit()
                                        Image("lock")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35, alignment: .center)
                                    }
                                }
                            }.cornerRadius(10)
                        }
                    }
                }
            }.padding(.horizontal, 20)
        }
        .fullScreenCover(isPresented: $showSubscriptionFlow, content: { SubscriptionFlow })
        .padding(.bottom, 40)
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
        )
        .edgesIgnoringSafeArea(.bottom)
    }
}
