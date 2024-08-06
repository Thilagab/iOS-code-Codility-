//
//  test.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 1/8/2024.
//

import Foundation

extension Date {
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}

// MARK: Transaction accounts grouped by date
func groupTransactionsByDate(transactions: [Transaction]) -> [Date: [Transaction]] {
    var groupedTransactions = [Date: [Transaction]]()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    
    for transaction in transactions {
        if let date = dateFormatter.date(from: transaction.effectiveDate)?.startOfDay() {
            if var dateTransactions = groupedTransactions[date] {
                dateTransactions.append(transaction)
                groupedTransactions[date] = dateTransactions
            } else {
                groupedTransactions[date] = [transaction]
            }
        }
    }
    
    return groupedTransactions
}

// Handling tranaction detail
class TransactionDetailViewModel: ObservableObject {
    @Published var groupedTransactions: [Date: [Transaction]] = [:]
    
    init(transactions: [Transaction]) {
        self.groupedTransactions = groupTransactionsByDate(transactions: transactions)
    }
}
