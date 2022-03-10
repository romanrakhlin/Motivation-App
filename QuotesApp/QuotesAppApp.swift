//
//  QuotesAppApp.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import SwiftUI
import PurchaseKit
import AppsFlyerLib
import UserNotifications

@main
struct QuotesAppApp: App {
    // for onboarding
    let onboardingDone = UserDefaults.standard.bool(forKey: "OnboardingDone")
    let data = OnboardingDataModel.data
    
    var body: some Scene {
        // for In-App Purchases
        PKManager.configure(sharedSecret: "YOUR-SHARED-SECRET")
        PKManager.loadProducts(identifiers: ["YOUR-PRODUCT'S-ID"])
        
        // for analytics
        AppsFlyerLib.shared().appsFlyerDevKey = "YOUR-KEY"
        AppsFlyerLib.shared().appleAppID = "YOUR-KEY"
        AppsFlyerLib.shared().start()
        
        return WindowGroup {
            if onboardingDone {
                ContentView()
            } else {
                OnboardingView(
                    data: data,
                    doneFunction: {
                        UserDefaults.standard.set(true, forKey: "OnboardingDone")
                        print("done onboarding")
                    }
                )
            }
        }
    }
}
