//
//  FavoritesView.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var savedQuotes: [String] = []
    
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
            }
            HStack {
                Text("Favorite Quotes")
                    .font(.system(size: 28, weight: .heavy, design: .rounded))
                    .padding(.horizontal, 20)
                Spacer()
            }
        }
        
        VStack {
            List {
                ForEach(savedQuotes, id: \.self) { quote in
                    if quote == "No saved quotes" {
                        Text(quote)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                    } else {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(getQuoteAndAuthor(gottenQuote: quote).0)")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                            Text("\(getQuoteAndAuthor(gottenQuote: quote).1)")
                                .font(.system(size: 12, weight: .light, design: .rounded))
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    }
                }
                .onDelete(perform: removeRows)
            }
        }
        .onAppear {
            var gottenArray = UserDefaults.standard.stringArray(forKey: "SavedQuotes") ?? ["No saved quotes"]
            if gottenArray.count == 0 {
                print("here")
                gottenArray.append("No saved quotes")
            }
            savedQuotes = gottenArray.reversed()
        }
    }
    
    private func getQuoteAndAuthor(gottenQuote: String) -> (String, String) {
        let components = gottenQuote.components(separatedBy: "—")
        return (components[0], components[1])
    }
    
    private func removeRows(at offsets: IndexSet) {
        savedQuotes.remove(atOffsets: offsets)
        UserDefaults.standard.set(self.savedQuotes, forKey: "SavedQuotes")
    }
}
