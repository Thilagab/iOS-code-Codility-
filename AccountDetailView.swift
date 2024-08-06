//
//  AccountDetailView.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 29/7/2024.
//

import SwiftUI

struct AccountDetailView: View {
    @StateObject var transactionViewModel = TransactionsViewModel()
    var completeAccess: Account
 
    var body: some View {
        NavigationStack(root: {
            VStack{
                // Account details
                AccountDetail(detail: completeAccess)
                if transactionViewModel.transaction.count > 0 {
                    let transaction = transactionViewModel.transaction
                    TransactionDetailView(transactions: transaction) }
                else {
                    Text("No transaction available") }
               Spacer()
                // Future development
                ATMTranaction(atm: transactionViewModel.transaction)
                
            }.navigationTitle("Complete Access")
            Spacer()
        }).onAppear(perform: {
            let accountNumber = completeAccess.accountNumber
            Task {
                await transactionViewModel.loadTransaction(accountNumber: accountNumber)
            }
        })
    }
}

//MARK: Account detail section
struct AccountDetail: View {
    var detail: Account
    
    var body: some View {
        VStack{
            HStack {
                Label(
                    title: { Text("Available") },
                    icon: {  })
                Spacer()
                Text("\(detail.available)")
            }.font(.title3)
                
            HStack {
                Label(
                    title: { Text("Balance") },
                    icon: {  })
                Spacer()
                Text("\(detail.balance)")
            }.font(.title3)
                .foregroundStyle(.gray)
                .padding(.top)
                
        }.padding(.all)
      
        HStack(){
            VStack(alignment: .leading){
                Label(
                    title: { Text("BSB \(detail.bsb)") },
                    icon: {  })
                
                Label(
                    title: { Text("Account \(detail.accountNumber)" ) },
                    icon: {  })
            }
            Spacer()
        }.headerStyle()
            
            .padding([.leading, .bottom, .trailing])
    }
    
}


#Preview {
    AccountDetailView(transactionViewModel: TransactionsViewModel(), completeAccess: Account(balance: "1000.00", accountNumber: "12345678", bsb: "987654", available: "950.00", accountName: "My Savings", currency: "AUD"))
}

