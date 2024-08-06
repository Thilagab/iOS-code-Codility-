//
//  TransactionService.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation
import CodeChallengeAPI

class TransactionService: APIServiceProtocol {
    
    typealias Response = [Transaction]
    var api: CodeChallengeAPI { return CodeChallengeAPI(seedDate: Date()) }
    typealias JSON = [String: Any]
    
    struct Constants {
        static let Key_ClearedTransactions = "cleared"
        static let Key_PendingTransactions = "pending"
        private init() {}
    }
 
    //Fetch transaction details
    func service(_ request: String?)  async throws -> Response {
        
        if let request = request {
            let data =  try  await api.getTransactionData(for: request)
            
            let jsonData = try JSONSerialization.jsonObject(with: data)
            guard let json = jsonData as? [String: [JSON]] else {
                throw NetworkError.unableToParseJSONDataFile }
            
            var clearedTransactions: [Transaction] = []
            var pendingTransactions: [Transaction] = []
            
            for object in json[Constants.Key_ClearedTransactions] ?? [] {
                if let transaction = Transaction(withJSON: object) {
                    var injectTransaction = transaction
                    injectTransaction.type = TransactionConstants.Key_ClearedTransactions
                    clearedTransactions.append(injectTransaction)
                    }
            }
            
            for object in json[Constants.Key_PendingTransactions] ?? [] {
                if let transaction = Transaction(withJSON: object) {
                    var injectTransaction = transaction
                    injectTransaction.type = TransactionConstants.Key_PendingTransactions
                    pendingTransactions.append(injectTransaction) }
            }
            
            return clearedTransactions + pendingTransactions }
        return []
    }
}

    
      
    
 
