//
//  CategoriesView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 05.11.2021.
//

import SwiftUI
import QuotesAppService

struct CategoriesView: View {
    @Binding var currentChoice: String
    @Binding var updatedQuotes: [Quote]
    @Environment(\.dismiss) var dismiss
    let viewModel = ContentViewModel()
    
    // rows
    let categoriesRowOne: [String] = ["love", "happiness", "spirituality"]
    let categoriesRowTwo: [String] = ["success", "life lessons", "philosophy"]
    
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
                Text("Categories")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .padding(.horizontal, 20)
                Spacer()
            }
        }
        
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                // MARK: - First Layer
                VStack(alignment: .leading) {
                    Text("Most Popular".uppercased())
                        .foregroundColor(.secondary)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // first unlocked
                            Button(action: {
                                saveUpdateQuotesAndQuit(category: "motivation")
                            }) {
                                ZStack {
                                    Image("motivation")
                                        .resizable()
                                        .squareImage()
                                        .scaledToFill()
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            if currentChoice == "motivation" {
                                                Image("selected")
                                                    .resizable()
                                                    .squareImage()
                                                    .frame(width: 45, height: 45)
                                                    .padding()
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text("motivation".capitalized)
                                                .foregroundColor(Color.white)
                                                .font(.headline)
                                                .font(.system(size: 18, design: .rounded))
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .cornerRadius(13)
                            
                            // second unlocked
                            Button(action: {
                                saveUpdateQuotesAndQuit(category: "wisdom")
                            }) {
                                ZStack {
                                    Image("wisdom")
                                        .resizable()
                                        .squareImage()
                                        .scaledToFill()
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            if currentChoice == "wisdom" {
                                                Image("selected")
                                                    .resizable()
                                                    .squareImage()
                                                    .frame(width: 45, height: 45)
                                                    .padding()
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text("wisdom".capitalized)
                                                .foregroundColor(Color.white)
                                                .font(.headline)
                                                .font(.system(size: 18, design: .rounded))
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .cornerRadius(13)
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // first unlocked
                            Button(action: {
                                saveUpdateQuotesAndQuit(category: "time")
                            }) {
                                ZStack {
                                    Image("time")
                                        .resizable()
                                        .squareImage()
                                        .scaledToFill()
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            if currentChoice == "time" {
                                                Image("selected")
                                                    .resizable()
                                                    .squareImage()
                                                    .frame(width: 45, height: 45)
                                                    .padding()
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text("time".capitalized)
                                                .foregroundColor(Color.white)
                                                .font(.headline)
                                                .font(.system(size: 18, design: .rounded))
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .cornerRadius(13)
                            
                            // second unlocked
                            Button(action: {
                                saveUpdateQuotesAndQuit(category: "inspirational")
                            }) {
                                ZStack {
                                    Image("inspirational")
                                        .resizable()
                                        .squareImage()
                                        .scaledToFill()
                                    
                                    VStack {
                                        HStack {
                                            Spacer()
                                            if currentChoice == "inspirational" {
                                                Image("selected")
                                                    .resizable()
                                                    .squareImage()
                                                    .frame(width: 45, height: 45)
                                                    .padding()
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text("inspirational".capitalized)
                                                .foregroundColor(Color.white)
                                                .font(.headline)
                                                .font(.system(size: 18, design: .rounded))
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                }
                            }
                            .cornerRadius(13)
                        }
                    }
                }
                
                // MARK: - Second Layer
                VStack(alignment: .leading) {
                    Text("Other".uppercased())
                        .foregroundColor(.secondary)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                    
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading, spacing: 20) {
                            // everything locked
                            ForEach(categoriesRowOne, id: \.self) { category in
                                Button(action: {
                                    if isSubscribed {
                                        saveUpdateQuotesAndQuit(category: category)
                                    } else {
                                        showSubscriptionFlow.toggle()
                                    }
                                }) {
                                    ZStack {
                                        Image(category)
                                            .resizable()
                                            .squareImage()
                                            .scaledToFill()
                                        
                                        VStack {
                                            HStack {
                                                Spacer()
                                                if currentChoice == category {
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
                                            
                                            HStack {
                                                Text(category.capitalized)
                                                    .foregroundColor(Color.white)
                                                    .font(.headline)
                                                    .font(.system(size: 18, design: .rounded))
                                                    .padding()
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .cornerRadius(14)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 20) {
                            // everything locked
                            ForEach(categoriesRowTwo, id: \.self) { category in
                                Button(action: {
                                    if isSubscribed {
                                        saveUpdateQuotesAndQuit(category: category)
                                    } else {
                                        showSubscriptionFlow.toggle()
                                    }
                                }) {
                                    ZStack {
                                        Image(category)
                                            .resizable()
                                            .squareImage()
                                            .scaledToFill()
                                        
                                        VStack {
                                            HStack {
                                                Spacer()
                                                if currentChoice == category {
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
                                            
                                            HStack {
                                                Text(category.capitalized)
                                                    .foregroundColor(Color.white)
                                                    .font(.headline)
                                                    .font(.system(size: 18, design: .rounded))
                                                    .padding()
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .cornerRadius(13)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .onAppear {
            currentChoice = UserDefaults.standard.string(forKey: "currentChoice") ?? "inspirational"
        }
        .fullScreenCover(isPresented: $showSubscriptionFlow, content: { SubscriptionFlow })
    }
    
    // MARK: - Supporting Functions
    private func saveUpdateQuotesAndQuit(category: String) {
        currentChoice = category
        UserDefaults.standard.set(category, forKey: "currentChoice")
        
        updatedQuotes = viewModel.getAllQuotes(by: currentChoice)
        
        dismiss()
    }
    
    private var SubscriptionFlow: some View {
        SubscribeView(
            title: "Motivation App",
            subtitle: "Daily Quotes",
            features: ["Enjoy your first 3 days trial, it’s free", "Cancel anytime from the settings", "Push notifications with quotes", "Categories for any situation", "Original themes"],
            productIds: ["yearly.productId"],
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
