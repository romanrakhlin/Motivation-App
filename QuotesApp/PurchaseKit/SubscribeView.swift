//
//  SubscribeView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 31.12.2021.
//

import SwiftUI
import PurchaseKit

struct SubscribeView: View {
    
    var title: String
    var subtitle: String
    var features: [String]
    var productIds: [String]
    @State var completion: PKCompletionBlock?
    var isOnboarding: Bool
    @Environment(\.dismiss) var dismiss
    @State private var goToMainScreen = false
    
    // Privacy Policy, Terms & Conditions URLs
    private let privacyPolicyURL: URL = URL(string: "YOUR-URL")!
    private let termsAndConditionsURL: URL = URL(string: "YOUR-URL")!
    
    // Main rendering function
    var body: some View {
        VStack {
            CloseButtonView
            
            Spacer()
            
            FeaturesListView
            
            Spacer()
            
            ProductsListView
            
            AdditionalView
            
            DisclaimerTextView
        }
        .background(
            Image("onboarding-background-5")
                .resizable()
                .scaledToFill()
        )
        .fullScreenCover(isPresented: $goToMainScreen, content: {
            ContentView()
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut)
                .transition(.move(edge: .bottom))
        })
        .ignoresSafeArea()
    }
    
    // MARK: - Header view
    private var HeaderSectionView: some View {
        VStack {
            // Title & Subtitle
            VStack {
                Text(title)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                Text(subtitle)
                    .font(.system(size: 24, weight: .medium, design: .rounded))
            }
            .foregroundColor(.white)
            .padding()
        }
    }
    
    // MARK: - Features scroll list view
    private var FeaturesListView: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Image("crown")
                        .foregroundColor(Color.yellow)
                    VStack(alignment: .leading) {
                        Text("Unlock")
                        Text("everything!")
                    }
                }
                .font(.system(size: 36, weight: .bold, design: .rounded))
                        
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(0..<features.count) { index in
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.green)
                            Text(features[index])
                        }
                    }
                }
                .font(.system(size: 16, weight: .regular, design: .rounded))
            }
            .padding(20)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 13))
    }
    
    // MARK: - List of products
    private var ProductsListView: some View {
        VStack(spacing: 10) {
            ForEach(0..<productIds.count) { index in
                Button(action: {
                    PKManager.purchaseProduct(identifier: self.productIds[index], completion: self.completion)
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color.white)
                            .frame(height: 50)
                        VStack {
                            Text("Start your free trial")
                                .foregroundColor(Color.black)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .foregroundColor(.white)
                    }
                })
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .padding(.top, 10)
    }
    
    // MARK: - Close button on the top header
    private var CloseButtonView: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    if isOnboarding {
                        goToMainScreen = true
                    } else {
                        self.dismiss()
                    }
                    PKManager.dismissInAppPurchaseScreen()
                }, label: {
                    Image("close")
                        .resizable()
                        .accentColor(.black)
                        .frame(width: 34, height: 34)
                })
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
    
    // MARK: - Privacy Policy, Terms & Conditions section
    private var AdditionalView: some View {
        HStack(spacing: 20) {
            Button(action: {
                UIApplication.shared.open(termsAndConditionsURL, options: [:], completionHandler: nil)
            }, label: {
                Text("Terms of use")
            })
            
            Divider()
            
            Button(action: {
                UIApplication.shared.open(privacyPolicyURL, options: [:], completionHandler: nil)
            }, label: {
                Text("Privacy Policy")
            })
            
            Divider()
            
            Button(action: {
                PKManager.restorePurchases { (error, status, id) in
                    self.completion?((error, status, id))
                    if isOnboarding {
                        goToMainScreen = true
                    } else {
                        self.dismiss()
                    }
                }
            }, label: {
                Text("Restore")
                    .foregroundColor(Color.black)
            }).foregroundColor(.white)
        }
        .font(.system(size: 14, weight: .regular, design: .rounded))
        .foregroundColor(Color.black)
        .frame(height: 30)
    }
    
    // MARK: - Disclaimer text view at the bottom
    private var DisclaimerTextView: some View {
        VStack {
            Text(PKManager.disclaimer)
                .font(.system(size: 12, weight: .light, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .foregroundColor(Color.black)
            Spacer(minLength: 40)
        }
    }
}
