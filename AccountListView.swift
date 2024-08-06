//
//  AccountListView.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 29/7/2024.
//

import SwiftUI

struct AccountListView: View {
    
    @ObservedObject var accountViewModel: AccountViewModel
    var body: some View {
        NavigationStack(root: {
            if accountViewModel.isLoading {
                ProgressView("Loading accounts.....")
            }
            else {
                List{
                    NavigationLink {
                        if let accessAccount = accountViewModel.completeAccessAccount {
                            AccountDetailView(completeAccess: accessAccount) // Destination Link
                        }
                    } label: {
                        if let completeAccessAccount = accountViewModel.completeAccessAccount {
                            CompleteAccessRow(account: completeAccessAccount)
                        }else {
                            Text("No Complete Access account available")
                        }
                    }
                    if let smartSavingAccount = accountViewModel.smartSavingAccount {
                        SmartSavingRow(account: smartSavingAccount)
                    }else {
                        Text("No Smart Saving account available")
                    }
                 }.navigationTitle("Accounts")
                    .toolbarBackground(
                        Color.init(cgColor: CGColor(red: 255, green: 204, blue: 0, alpha: 1)),
                                    for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
            }
        }).onAppear(perform: {
            Task {
                await accountViewModel.loadAccount()
            }
        })
    }
}

// Header style for Text view
struct HeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.gray)
            .fontWeight(.light)
    }
}

extension View {
    func headerStyle() -> some View {
        self.modifier(HeaderStyle())
    }
}

#Preview {
    AccountListView(accountViewModel: AccountViewModel())
}




