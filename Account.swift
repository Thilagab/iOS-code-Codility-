//
//  Account.swift
//  iOS Code Challenge
//
//  Created by Morrison, Ben on 21/3/2023.
//

import Foundation

struct Account {
    let balance: String
    let accountNumber: String
    let bsb: String
    let available: String
    let accountName: String
    let currency: String

    init?(withJSON json: Network.JSON) {
        guard let balance = json["balance"] as? String else { return nil }
        guard let accountNumber = json["accountNumber"] as? String else { return nil }
        guard let bsb = json["bsb"] as? String else { return nil }
        guard let available = json["available"] as? String else { return nil }
        guard let accountName = json["accountName"] as? String else { return nil }
        guard let currency = json["currency"] as? String else { return nil }

        self.balance = balance
        self.accountNumber = accountNumber
        self.bsb = bsb
        self.available = available
        self.accountName = accountName
        self.currency = currency
    }
    
    // Convenience initializer
        init(balance: String, accountNumber: String, bsb: String, available: String, accountName: String, currency: String) {
            self.balance = balance
            self.accountNumber = accountNumber
            self.bsb = bsb
            self.available = available
            self.accountName = accountName
            self.currency = currency
        }
    
}



