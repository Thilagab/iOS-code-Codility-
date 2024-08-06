//
//  AccountService.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation
import CodeChallengeAPI

// Call CodeChallengeAPI service to fetch account details
class AccountService: APIServiceProtocol {
     
    typealias Response = [Account]
    
    var api: CodeChallengeAPI { return CodeChallengeAPI(seedDate: Date()) }
    typealias JSON = [String: Any]
    
    func service(_ request: String?)  async throws -> Response {
        
        let data =    try await api.getAccountsListData()
        
        let jsonData = try JSONSerialization.jsonObject(with: data)
        guard let json = jsonData as? [JSON] else {
            throw NetworkError.unableToParseJSONDataFile }
        
        var accounts: [Account] = []
        for object in json {
            if let account = Account(withJSON: object) {
                accounts.append(account) }
        }
        return accounts
    }
    
}
