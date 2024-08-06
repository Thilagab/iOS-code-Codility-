//
//  Networking.swift
//  iOS Code Challenge
//
//  Created by Morrison, Ben on 20/3/2023.
//

import Foundation
import CodeChallengeAPI

final class Network {
    let api = CodeChallengeAPI(seedDate: Date())

    typealias JSON = [String: Any]
    static var shared = Network()

    struct Constants {
        static let Key_ClearedTransactions = "cleared"
        static let Key_PendingTransactions = "pending"
        private init() {}
    }

    func accounts(_ callback: @escaping (Result<[Account], Error>) -> ()){
        api.getAccountsListData { result in
            switch result {
            case .failure(let error):
                callback(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data)
                    guard let json = jsonData as? [JSON] else {
                        callback(.failure(NetworkError.unableToParseJSONDataFile))
                        return
                    }

                    var accountList: [Account] = []
                    for object in json {
                        if let account = Account(withJSON: object) {
                            accountList.append(account)
                        }
                    }
                    callback(.success(accountList))
                } catch {
                    callback(.failure(error))
                }
            }
        }
    }

    func getTransactionsFor(_ accountNumber: String, _ callback: @escaping (Result<[String: [Transaction]], Error>) -> ()) {
        api.getTransactionData(for: accountNumber) { result in
            switch result {
            case.failure(let error):
                callback(.failure(error))
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data)
                    guard let json = jsonData as? [String: [JSON]] else {
                        callback(.failure(NetworkError.unableToGetDataFile))
                        return
                    }

                    var clearedTransactions: [Transaction] = []
                    var pendingTransactions: [Transaction] = []

                    for object in json[Constants.Key_ClearedTransactions] ?? [] {
                        if let transaction = Transaction(withJSON: object) {
                            clearedTransactions.append(transaction)
                        }
                    }

                    for object in json[Constants.Key_PendingTransactions] ?? [] {
                        if let transaction = Transaction(withJSON: object) {
                            pendingTransactions.append(transaction)
                        }
                    }

                    callback(.success([
                        Constants.Key_PendingTransactions: pendingTransactions,
                        Constants.Key_ClearedTransactions: clearedTransactions
                    ]))


                } catch {
                    callback(.failure(error))
                }
            }
        }
    }
}

enum NetworkError: String, Error {
    case unableToGetDataFile
    case unableToParseJSONDataFile
}
