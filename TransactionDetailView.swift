//
//  TransactionDetailView.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 1/8/2024.
//

import SwiftUI

//MARK: Transaction detail section


struct TransactionDetailView: View {
   
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var transactionDetailViewModel: TransactionDetailViewModel
    
    init(transactions: [Transaction]) {
        _transactionDetailViewModel = StateObject(wrappedValue: TransactionDetailViewModel(transactions: transactions))
    }
    
    var body: some View {
        List {
            ForEach(transactionDetailViewModel.groupedTransactions.keys.sorted(by: >), id: \.self) { date in
                Section(header: Text(date, formatter: transactionDateFormatter).modifier(headerModifier()) ) {
                    ForEach(transactionDetailViewModel.groupedTransactions[date]!) { transaction in
                        HStack(alignment: .top) {
                            if transaction.type == TransactionConstants.Key_PendingTransactions {
                                Text("PENDING:").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                Text("\(transaction.description)")
                            }else {
                                Text("\(transaction.description)") }
                                Spacer()
                            Text("\(transaction.amount)").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }//.foregroundStyle( colorScheme == .dark ? .white : .black )
                    }
                }.modifier(sectionModifier())
            }
        }.listStyle(InsetListStyle())
        .listRowBackground(Color.gray)
        
    }
}


//MARK: ViewModifier
struct headerModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body (content: Content) -> some View {
        content
            .foregroundStyle( colorScheme == .dark ? .white : .black )
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .frame(height: 30)
            .frame(width: 380, height: 30,alignment: .leading)
            .background(Color.init(cgColor: CGColor(red: 255, green: 204, blue: 0, alpha: 0.4)))
            
    }
}
struct sectionModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body (content: Content) -> some View {
        content
            .background(colorScheme == .dark ? .black : .white)
             .background(Color.init(cgColor: CGColor(red: 246, green: 246, blue: 246, alpha: 1)))
             .scrollContentBackground(.hidden)
            
    }
}

private let transactionDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()


#Preview {
    TransactionDetailView(transactions: [Transaction(amount: "200.00", id: "211", description: "Eat out", effectiveDate: "11/06/2023", category: "Eat", type: "cleared"),Transaction(amount: "200.00", id: "211", description: "Eat out", effectiveDate: "12/06/2023", category: "Eat", type: "cleared")])
}


