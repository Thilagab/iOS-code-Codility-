//
//  Transaction.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation

struct Transaction: Identifiable {
    let amount: String
    let id: String
    let description: String
    let effectiveDate: String
    let category: String
    var type: String?
    
    init?(withJSON json: Network.JSON) {
        guard let amount = json["amount"] as? String else { return nil }
        guard let id = json["id"] as? String else { return nil }
        guard let description = json["description"] as? String else { return nil }
        guard let effectiveDate = json["effectiveDate"] as? String else { return nil }
        guard let category = json["category"] as? String else { return nil }

        self.amount = amount
        self.id = id.replacingOccurrences(of: "<br/>", with: "\n")
        self.description = description
        self.effectiveDate = effectiveDate
        self.category = category
        self.type = nil
        
    }
    
    // Convenience initializer
    init(amount: String, id: String, description: String, effectiveDate: String, category: String, type: String) {
            self.amount = amount
            self.id = id
            self.description = description
            self.effectiveDate = effectiveDate
            self.category = category
            self.type = type
        }
}

struct TransactionConstants {
    static let Key_ClearedTransactions = "cleared"
    static let Key_PendingTransactions = "pending"
    private init() {}
}
