//
//  ContentViewModel.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import Foundation
import SwiftUI
import QuotesAppService

struct ContentViewModel {
    
    let service = QuoteService()
    
    func refreshQuote(quote: Quote?) -> Quote {
        return service.getSequentialQuote(input: quote, category: UserDefaults.standard.string(forKey: "currentChoice") ?? "inspirational")
    }
    
    func getAllQuotes(by: String) -> [Quote] {
        let arrayOfQuotes = service.getQuotes(by: by)
        return arrayOfQuotes.shuffled()
    }
    
    func getRandomQuote() -> String {
        let randomQuote = service.getRandomQuote()
        return randomQuote.quote
    }
}
