//
//  TransactionCardView.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI

struct TransactionCardView: View {
    //MARK:  PROPERTIES
    @Environment(\.modelContext) private var context
    var transaction: Transaction
    var showsTransactionType: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            
            Text(transaction.title)
                .foregroundStyle(Color.primary)
            
            Text(transaction.remarks)
                .font(.caption)
                .foregroundStyle(Color.primary.secondary)
            
            Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                .font(.caption2)
                .foregroundStyle(.colorGrey)
            
            if showsTransactionType {
                Text(transaction.transactionType)
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .foregroundStyle(.white)
                    .background(transaction.transactionType == TransactionType.income.rawValue ? Color.colorGreen.gradient : Color.colorRed.gradient, in: .capsule)
            }
        })
        
        Text(currencyString(transaction.amount, allowedDigits: 2))
            .fontWeight(.semibold)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(.background, in: .rect(cornerRadius: 10))
   
    }
}
