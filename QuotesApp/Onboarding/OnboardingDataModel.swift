//
//  OnboardingDataModel.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 05.11.2021.
//

import Foundation

struct OnboardingDataModel {
    var heading: String
    var text: String
    var background: String
}

extension OnboardingDataModel {
    static var data: [OnboardingDataModel] = [
        OnboardingDataModel(heading: "Welcome!", text: "Self care. Self love. Self growth.", background: "onboarding-background-1"),
        OnboardingDataModel(heading: "Do you want to get daily reminders?", text: "Every day at the same time you gonna receive a personal push notification with quotes you need.", background: "onboarding-background-2"),
        OnboardingDataModel(heading: "Try our widget", text: "You can see personalized quotes on your home screen without opening the app.", background: "onboarding-background-3"),
        OnboardingDataModel(heading: "Personalize your quotes", text: "Choose the desired categories of quotes you need in life now.", background: "onboarding-background-4"),
    ]
}
