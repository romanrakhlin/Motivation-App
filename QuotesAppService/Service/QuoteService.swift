//
//  QuoteService.swift
//  QuotesAppService
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import Foundation
import SwiftUI

public struct QuoteService {
    
    static var idx = 0
    var quotes: [Quote] = []
    
    public init() {
        guard
            let bundle = Bundle(identifier: "com.romanrakhlin.QuotesApp.QuotesAppService"),
            let path = bundle.path(forResource: "quotes", ofType: "json"),
            let data = try? String(contentsOfFile: path).data(using: .utf8) else {
                return
            }
        
        do {
            quotes = try JSONDecoder().decode([Quote].self, from: data)
        } catch {
            print("error loading quotes from quotes.json")
        }
    }

    public func getColors(_ quote: Quote) -> [Color] {
        var colors: [[Color]] = []
        colors.append([Color.init(UIColor.init(hex: "#434343")), Color.init(UIColor.init(hex: "#000000"))])
        colors.append([Color.init(UIColor.init(hex: "#667eea")), Color.init(UIColor.init(hex: "#764ba2"))])
        colors.append([Color.init(UIColor.init(hex: "#868f96")), Color.init(UIColor.init(hex: "#596164"))])
        colors.append([Color.init(UIColor.init(hex: "#09203f")), Color.init(UIColor.init(hex: "#537895"))])
        colors.append([Color.init(UIColor.init(hex: "#29323c")), Color.init(UIColor.init(hex: "#485563"))])
        colors.append([Color.init(UIColor.init(hex: "#1e3c72")), Color.init(UIColor.init(hex: "#2a5298"))])

        return colors.randomElement() ?? [Color.black, Color.black]
    }

    public func getRandomQuote() -> Quote {
        let currentChoice = UserDefaults.standard.string(forKey: "currentChoice") ?? "inspirational"
        var quote = quotes.randomElement() ?? getTestQuote()
        while quote.category != currentChoice {
            quote = quotes.randomElement() ?? getTestQuote()
        }
        return quote
    }

    public func findIdx(_ input: Quote) -> Int {
        let idx = quotes.firstIndex { quote -> Bool in
            return quote.quote == input.quote && quote.category == input.category
        }

        return idx ?? -1
    }

    public func getSequentialQuote(input: Quote? = nil, category: String) -> Quote {
        var index = input != nil ? findIdx(input!) : QuoteService.idx
        index = Int.random(in: 0..<quotes.count)
        QuoteService.idx = index
        
        var quoteToReturn: Quote = quotes[index]
        
        if quoteToReturn.category == "lifeLessons" {
            quoteToReturn.category = "life lessons"
        }
        
        while quoteToReturn.category != category {
            index = Int.random(in: 0..<quotes.count)
            QuoteService.idx = index
            quoteToReturn = quotes[index]
        }

        return quoteToReturn
    }
    
    public func getQuotes(by: String) -> [Quote] {
        var to_return: [Quote] = []
        var counter = 0
        for quote in quotes {
            if counter > 200 {
                break
            }
            if quote.category == by {
                to_return.append(quote)
                counter += 1
            }
        }
        return to_return
    }

    public func getTestQuote() -> Quote {
        let sample = Quote(quote: "Whatever we expect with confidence becomes our own self-fulfilling prophecy. - Brian Tracy", category: "love")
        return sample
    }
}

extension UIColor {
    
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat
        let hex = hex + "ff"

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        self.init(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
        return
    }
}

struct Rescale {
    
    let range0: Double
    let range1: Double
    let domain0: Double
    let domain1: Double

    init(domain0: Double, domain1: Double, range0: Double, range1: Double) {
        self.range0 = range0
        self.range1 = range1
        self.domain0 = domain0
        self.domain1 = domain1
    }

    func interpolate(_ x: Double) -> Double {
        return range0 * (1 - x) + range1 * x;
    }

    func uninterpolate(_ x: Double) -> Double {
        let b: Double = (domain1 - domain0) != 0 ? domain1 - domain0 : 1 / domain1
        return (x - domain0) / b
    }

    func rescale(x: Double)  -> Double {
        return interpolate(uninterpolate(x))
    }
}

