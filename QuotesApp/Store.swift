//
//  Store.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 04.12.2021.
//

import StoreKit

class Store: NSObject, ObservableObject {
    private let identifier = "com.romanrakhlin.QuotesApp.yearlyPremium"
}

extension Store: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
    }
}
