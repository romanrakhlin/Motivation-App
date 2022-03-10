//
//  QuoteView.swift
//  QuotesAppService
//
//  Created by Roman Rakhlin on 01.11.2021.
//

import SwiftUI

public struct QuoteView: View {
    
    @State var liked: Bool = false
    let backgroundImage = UserDefaults.standard.string(forKey: "SavedBackground") ?? "back-0"
    public var quote: Quote

    public init(quote: Quote) {
        self.quote = quote
    }
    
    var quoteTextView: some View {
        VStack {
            Text(getQuoteAndAuthor(quote: quote).0)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .shadow(color: .black, radius: 2)
            Text(getQuoteAndAuthor(quote: quote).1)
                .font(.system(size: 18, weight: .light, design: .rounded))
                .shadow(color: .black, radius: 2)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .multilineTextAlignment(.center)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }

    public var body: some View {
        ZStack {
            VStack {
                VStack {
                    Rectangle()
                        .frame(width: 50, height: 50, alignment: .center)
                        .foregroundColor(.clear)
                    quoteTextView
                }
                .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Button(action: {
                        print("Like Tapped")
                        liked.toggle()
                        
                        if liked {
                            addToFavorites(quote: quote)
                        } else {
                            removeFromFavorites(quote: quote)
                        }
                        
                        // some haptic thing
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }) {
                        Image(systemName: liked == false ? "heart" : "heart.fill")
                            .renderingMode(.original)
                            .padding()
                    }
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(14)
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        print("Share tapped")
                        shareQuote(quote: quote)

                        // some haptic thing
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.original)
                            .padding()
                    }
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(14)
                    .buttonStyle(PlainButtonStyle())
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func getQuoteAndAuthor(quote: Quote) -> (String, String) {
        let components = quote.quote.components(separatedBy: "—")
        return (components[0], components[1])
    }
    
    func addToFavorites(quote: Quote) {
        var savedQuotes = UserDefaults.standard.stringArray(forKey: "SavedQuotes") ?? []
        let newQuote = "\(quote.quote)"
        if !savedQuotes.contains(newQuote) {
            savedQuotes.append(newQuote)
            UserDefaults.standard.set(savedQuotes, forKey: "SavedQuotes")
        }
        print("added quote to favorives!")
    }
    
    func removeFromFavorites(quote: Quote) {
        var savedQuotes = UserDefaults.standard.stringArray(forKey: "SavedQuotes") ?? []
        let newQuote = "\(quote.quote)"
        for i in 0..<savedQuotes.count {
            if savedQuotes[i] == newQuote {
                savedQuotes.remove(at: i)
                UserDefaults.standard.set(savedQuotes, forKey: "SavedQuotes")
                print("removed quote from favorites")
                return
            }
        }
        return
    }
    
    func shareQuote(quote: Quote) {
        quoteTextView
            .background(Image(backgroundImage))
            .saveAsImage(width: 500, height: 300) { image in
                let av = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
            }
    }
}

public struct QuoteShuffleLogoView: View {
    public var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 58, height: 48, alignment: .center)
        }.padding()
    }
}

extension View {
    func saveAsImage(width: CGFloat, height: CGFloat, _ completion: @escaping (UIImage) -> Void) {
        let size = CGSize(width: width, height: height)
        
        let controller = UIHostingController(rootView: self.frame(width: width, height: height))
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        
        completion(image)
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}

// MARK: - for detecting double tap
struct TapCountRecognizerModifier: ViewModifier {
    
    let tapSensitivity: Int
    let doubleTapAction: (() -> Void)?
    
    init(tapSensitivity: Int = 250, doubleTapAction: @escaping (() -> Void)) {
        
        self.tapSensitivity  = ((tapSensitivity >= 0) ? tapSensitivity : 250)
        self.doubleTapAction = doubleTapAction
        
    }
    
    @State private var tapCount: Int = Int()
    @State private var currentDispatchTimeID: DispatchTime = DispatchTime.now()
    
    func body(content: Content) -> some View {
        return content
            .gesture(fundamentalGesture)
    }
    
    var fundamentalGesture: some Gesture {
        DragGesture(minimumDistance: 0.0, coordinateSpace: .local)
            .onEnded() { _ in tapCount += 1; tapAnalyzerFunction() }
    }
    
    func tapAnalyzerFunction() {
        currentDispatchTimeID = dispatchTimeIdGenerator(deadline: tapSensitivity)
        if tapCount == 2 {
            let doubleTapGestureDispatchTimeID: DispatchTime = currentDispatchTimeID
            DispatchQueue.main.asyncAfter(deadline: doubleTapGestureDispatchTimeID) {
                if (doubleTapGestureDispatchTimeID == currentDispatchTimeID) {
                    if let unwrappedDoubleTapAction: () -> Void = doubleTapAction { unwrappedDoubleTapAction() }
                    tapCount = 0
                }
            }
        }
    }
    
    func dispatchTimeIdGenerator(deadline: Int) -> DispatchTime { return DispatchTime.now() + DispatchTimeInterval.milliseconds(deadline)
    }
}

extension View {
    func tapCountRecognizer(tapSensitivity: Int = 250, singleTapAction: (() -> Void)? = nil, doubleTapAction: (() -> Void)? = nil, tripleTapAction: (() -> Void)? = nil) -> some View {
        return self.modifier(TapCountRecognizerModifier(tapSensitivity: tapSensitivity, doubleTapAction: doubleTapAction!))
    }
}
