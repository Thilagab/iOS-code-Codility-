//
//  AccountViewModel.swift
//          iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 30/7/2024.
//

import Foundation
import SwiftUI
import Observation


// Handling accounts
class AccountViewModel: ObservableObject{
   
    private var accounts: [Account] = []
    @Published var completeAccessAccount: Account?
    @Published var smartSavingAccount: Account?
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    init() {
        self.accounts = []
        self.completeAccessAccount = nil
        self.smartSavingAccount = nil
        self.error = nil
        self.isLoading = false
    }

    init(accounts: [Account], completeAccessAccount: Account?, smartSavingAccount: Account?, error: String? = nil) {
        self.accounts = accounts
        self.completeAccessAccount = completeAccessAccount
        self.smartSavingAccount = smartSavingAccount
        self.error = error
        self.isLoading = false
    }
    
    // Load account details from API service
    @MainActor
    func loadAccount() async {
        isLoading = true
        
        let accountService = AccountService()
        do {
            accounts =  try await sendAsync(apiService: accountService, forTransaction: nil)
            
            DispatchQueue.main.async {
            
                self.isLoading = false
                guard self.accounts.count > 0 else { return }
                self.seperateAccount()   }
            
        } catch {
            print(#function,error.localizedDescription)
        }
       
    }

    // Seperate the different account 
    private func seperateAccount() {
        for account in accounts {
            if account.accountName == "Complete Access" {
                self.completeAccessAccount = account
            } else if account.accountName == "Smart Savings" {
                smartSavingAccount = account
            }
        }
    }
}

