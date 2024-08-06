//
//  TransactionsViewModel.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation
import SwiftUI

// Handling transactions
class TransactionsViewModel: ObservableObject {
    
    var accountNumber: String?
    @Published var transaction: [Transaction] = []
    @Published var clearTransaction: [Transaction] = []
    @Published var pendingTransaction: [Transaction] = []
    @Published var error: String?
    
    init() {
        self.transaction = []
        self.clearTransaction = []
        self.pendingTransaction = []
        self.error = nil
        self.accountNumber = nil
    }

    init(transaction: [Transaction], clearTransaction: [Transaction], pendingTransaction: [Transaction], error: String? = nil) {
        self.transaction = transaction
        self.clearTransaction = clearTransaction
        self.pendingTransaction = pendingTransaction
        self.error = error
    }
   
    //Load transaction  details from API Service
    @MainActor
    func loadTransaction(accountNumber: String?) async {
        
        let transactionService = TransactionService()
        do {
            transaction = try await sendAsync(apiService: transactionService, forTransaction: accountNumber)
        } catch {
            print(#function,error.localizedDescription)
        }
    }
}
  
