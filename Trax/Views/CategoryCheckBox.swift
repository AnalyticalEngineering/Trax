//
//  CategoryCheckBox.swift
//  Trax
//
//  Created by J. DeWeese on 1/30/24.
//

import SwiftUI

struct CategoryCheckBox: View {
    @State private var transactionType: TransactionType = .expense
    var body: some View {
        HStack(spacing: 10) {
            ForEach(TransactionType.allCases, id: \.rawValue) { transactionType in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(appTint)
                        
                        if self.transactionType == transactionType {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(appTint)
                        }
                    }
                    
                    Text(transactionType.rawValue)
                        .font(.caption)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.transactionType = transactionType
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
      
    }
}
#Preview {
    CategoryCheckBox()
}
