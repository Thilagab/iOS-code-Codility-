//
//  ATMTranaction.swift
//  iOS Code Challenge
//
//  Created by Thilagawathy Duraisamy on 1/8/2024.
//

import SwiftUI

//MARK: ATM location section
struct ATMTranaction: View {

    var atm: [Transaction]
    var body: some View {
        
            VStack{
                ForEach(atm) { transaction in
                    if  transaction.description.contains("ATM") {
                        HStack{
                            Image(systemName: "mappin.and.ellipse")
                            Text("\(transaction.description)")
                            Spacer()
                            Text("\(transaction.amount)")}
                    }
                }.padding(.horizontal)
        }
            
    }
}


#Preview {
    ATMTranaction(atm: [Transaction(amount: "200.00", id: "211", description: " money taken out ATM", effectiveDate: "11/06/2023", category: "Eat", type: "cleared"),
            Transaction(amount: "200.00", id: "211", description: "Withdrawal CBA ATM Circular Quay Station NSW 221092: ", effectiveDate: "11/06/2023", category: "Eat", type: "cleared")])
}
