//
//  AccountRow.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 29/7/2024.
//

import SwiftUI

// MARK: Complete Access detail
struct CompleteAccessRow: View {
    
   var account: Account
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top){
                Image("icon_EverydaySavingsAccount")
                VStack(alignment: .leading) {
                    Text("Complete Access")
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                    
                    Text("\(account.bsb) \(account.accountNumber)")
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
}

#Preview {
    CompleteAccessRow(account: Account(balance: "1000.00", accountNumber: "12345678", bsb: "987654", available: "950.00", accountName: "My Savings", currency: "AUD")
    )
}
