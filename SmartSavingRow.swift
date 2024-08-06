//
//  SmartSavingRow.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 29/7/2024.
//

import SwiftUI

// MARK: Smart saving account
struct SmartSavingRow: View {
    var account: Account
    
    var body: some View {
        HStack(alignment:.top){
            Image("icon_GoalSaverAccount")
            VStack(alignment: .leading) {
                Text("Smart Savings")
                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                Text("\(account.bsb)  \(account.accountNumber)")
                    .headerStyle()
                HStack {
                    Text("Available Balance")
                        .headerStyle()
                    Spacer()
                    Text("\(account.available)")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }.padding(.top)
                HStack {
                    Text("Balance")
                    Spacer()
                    Text("\(account.balance)")
                }.headerStyle()
            }
        }
    }
}

#Preview {
    SmartSavingRow(account: Account(balance: "1000.00", accountNumber: "123 456 78", bsb: "987 654", available: "950.00", accountName: "My Savings", currency: "AUD"))
}
