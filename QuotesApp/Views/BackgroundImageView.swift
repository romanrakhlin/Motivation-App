//
//  BackgroundImageView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 02.11.2021.
//

import SwiftUI

struct BackgroundImageView: View {
    
    @Binding var backgroundImagee: String
    @Environment(\.dismiss) var dismiss
    
    // rows
    let categoriesRowOne: [String] = ["back-1", "back-2", "back-3", "back-4", "back-5", "back-6", "back-7", "back-8", "back-9", "back-10", "back-11", "back-12", "back-13", "back-14", "back-15", "back-16", "back-17", "back-18"]
    let categoriesRowTwo: [String] = ["back-20", "back-21", "back-22", "back-23", "back-24", "back-25", "back-26", "back-27", "back-28", "back-29", "back-30", "back-31", "back-32", "back-33", "back-34", "back-35", "back-36", "back-37", "back-38"]
    
    // work with subscribtion
    @Binding var isSubscribed: Bool
    @State private var showSubscriptionFlow: Bool = false
    
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
                Text("Background")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .padding(.horizontal, 20)
                Spacer()
            }
        }
        
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                VStack(alignment: .leading, spacing: 20) {
                    Button(action: {
                        UserDefaults.standard.set("back-0", forKey: "SavedBackground")
                        backgroundImagee = "back-0"
                        dismiss()
                    }) {
                        ZStack {
                            Image("back-0")
                                .resizable()
                                .squareImage()
                            
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    if backgroundImagee == "back-0" {
                                        Image("selected")
                                            .resizable()
                                            .squareImage()
                                            .frame(width: 45, height: 45)
                                            .padding()
                                    }
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .cornerRadius(14)
                    
                    ForEach(categoriesRowOne, id: \.self) { background in
                        Button(action: {
                            if isSubscribed {
                                UserDefaults.standard.set(background, forKey: "SavedBackground")
                                backgroundImagee = background
                                dismiss()
                            } else {
                                showSubscriptionFlow.toggle()
                            }
                        }) {
                            ZStack {
                                Image(background)
                                    .resizable()
                                    .squareImage()
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        if backgroundImagee == background {
                                            Image("selected")
                                                .resizable()
                                                .squareImage()
                                                .frame(width: 45, height: 45)
                                                .padding()
                                        } else {
                                            if !isSubscribed {
                                                Image("lock")
                                                    .resizable()
                                                    .squareImage()
                                                    .frame(width: 45, height: 45)
                                                    .padding()
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        .cornerRadius(14)
                    }
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(categoriesRowTwo, id: \.self) { background in
                        Button(action: {
                            if isSubscribed {
                                UserDefaults.standard.set(background, forKey: "SavedBackground")
                                backgroundImagee = background
                                dismiss()
                            } else {
                                showSubscriptionFlow.toggle()
                            }
                        }) {
                            ZStack {
                                Image(background)
                                    .resizable()
                                    .squareImage()
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        
                                        if backgroundImagee == background {
                                            Image("selected")
                                                .resizable()
                                                .squareImage()
                                                .frame(width: 45, height: 45)
                                                .padding()
                                        } else {
                                            if !isSubscribed {
                                                Image("lock")
                                                    .resizable()
                                                    .squareImage()
                                                    .frame(width: 45, height: 45)
                                                    .padding()
                                            }
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        .cornerRadius(14)
                    }
                }
            }
            .padding(.bottom, 40)
        }
        .fullScreenCover(isPresented: $showSubscriptionFlow, content: { SubscriptionFlow })
        .padding(.horizontal, 20)
    }
    
    private var SubscriptionFlow: some View {
        SubscribeView(
            title: "Motivation App",
            subtitle: "Daily Quotes",
            features: ["Enjoy your first 3 days trial, it’s free", "Cancel anytime from the settings", "Push notifications with quotes", "Categories for any situation", "Original themes"],
            productIds: ["YOUR-PRODUCT'S-ID"],
            completion: { error, status, _ in
                // Handle the error and status for each in-app purchase based on the productIdentifier
                if status == .success || status == .restored {
                    // If the purchase was successful or restored, unlock any content, remove ads or do anything you have to do
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
