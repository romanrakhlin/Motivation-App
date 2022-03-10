//
//  FeedbackManager.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 02.11.2021.
//

import UIKit

enum FeedbackManager {
    static func mediumFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
